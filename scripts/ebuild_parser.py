#!/usr/bin/env python
from __future__ import annotations

from dataclasses import dataclass, field
from typing import Collection, Iterator
import re


@dataclass
class EbuildPhase:
    """Represents a phase function in an ebuild."""

    name: str
    body: str
    line_start: int
    line_end: int


@dataclass(frozen=True)
class Dependency:
    """Represents a package dependency."""

    package: str
    slot: str = ''
    subslot: str = ''
    slot_operator: str = ''
    version_constraint: str = ''
    version: str = ''
    use_flags: tuple[str, ...] = field(default_factory=tuple)


@dataclass
class EbuildParser:
    """Parser for Gentoo ebuild files."""

    path: str
    content: str = field(default='', init=False)
    variables: dict[str, str] = field(default_factory=dict, init=False)
    phases: dict[str, EbuildPhase] = field(default_factory=dict, init=False)
    eclasses: list[str] = field(default_factory=list, init=False)

    def __post_init__(self) -> None:
        with open(self.path) as f:
            self.content = f.read()
        self._parse()

    def _parse(self) -> None:
        """Parse the ebuild content."""
        self._extract_eclasses()
        self._extract_variables()
        self._extract_phases()

    def _extract_eclasses(self) -> None:
        """Extract inherited eclasses."""
        if m := re.search(r'^inherit\s+(.+)$', self.content, re.MULTILINE):
            self.eclasses = m.group(1).split()

    def _extract_variables(self) -> None:
        """Extract variable assignments."""
        lines = self.content.splitlines()
        i = 0
        while i < len(lines):
            line = lines[i]
            stripped = line.strip()
            if not stripped or stripped.startswith('#') or stripped.startswith('inherit'):
                i += 1
                continue
            if m := re.match(r'^([A-Z_][A-Z0-9_]*)=(.*)$', stripped):
                name, value = m.groups()
                value = value.strip()
                if value.startswith('('):
                    paren_count = value.count('(') - value.count(')')
                    parts = [value]
                    while paren_count > 0 and i + 1 < len(lines):
                        i += 1
                        parts.append(lines[i])
                        paren_count += lines[i].count('(') - lines[i].count(')')
                    self.variables[name] = '\n'.join(parts)
                elif value.startswith('"'):
                    quote_count = value.count('"')
                    parts = [value]
                    while quote_count % 2 != 0 and i + 1 < len(lines):
                        i += 1
                        parts.append(lines[i])
                        quote_count += lines[i].count('"')
                    self.variables[name] = '\n'.join(parts).strip('"')
                elif value.startswith("'"):
                    parts = [value]
                    while not value.endswith("'") and i + 1 < len(lines):
                        i += 1
                        parts.append(lines[i].strip())
                        value = parts[-1]
                    self.variables[name] = '\n'.join(parts).strip("'")
                else:
                    self.variables[name] = value
            i += 1

    def _extract_phases(self) -> None:
        """Extract phase functions."""
        lines = self.content.splitlines()
        i = 0
        while i < len(lines):
            line = lines[i]
            stripped = line.strip()
            if m := re.match(r'^(src_\w+|pkg_\w+)\s*\(\s*\)\s*\{?$', stripped):
                phase_name = m.group(1)
                start_line = i
                brace_count = 1 if stripped.endswith('{') else 0
                body_lines = []
                i += 1
                if brace_count == 0:
                    while i < len(lines) and lines[i].strip() != '{':
                        i += 1
                    if i < len(lines):
                        brace_count = 1
                        i += 1
                while i < len(lines) and brace_count > 0:
                    current = lines[i]
                    brace_count += current.count('{') - current.count('}')
                    if brace_count > 0:
                        body_lines.append(current)
                    i += 1
                self.phases[phase_name] = EbuildPhase(name=phase_name,
                                                      body='\n'.join(body_lines),
                                                      line_start=start_line,
                                                      line_end=i - 1)
            else:
                i += 1

    def get_variable(
        self,
        name: str,
        skip_expand: Collection[str] | None = None,
        *,
        convert: bool = False,
        expand: bool = False,
        integer_to_bool: bool = False,
        str_to_bool: bool = False
    ) -> str | list[str] | bool | dict[str, str] | dict[str, set[str]] | dict[
            str, set[Dependency]] | None:
        """Get a variable value by name.

        Parameters
        ----------
        name : str
            Variable name.
        convert : bool
            If True, apply type conversions: '1' to True, arrays/space-delimited to lists.
            SRC_URI returns dict[uri, filename].
        expand : bool
            If True, expand variable references like ``${VAR}``. Unknown variables become
            ``'__{var_name}_VARIABLE_ASSIGNED_BY_ECLASS_OR_IS_UNSET__'``.
        skip_expand : list[str] | None
            List of variable names to skip during expansion.
        integer_to_bool : bool
            If ``True``, convert ``'1'`` to True and ``'0'`` to False.
        str_to_bool : bool
            If ``True``, convert 'true'/'false' (case-insensitive) to bool.

        Returns
        -------
        str | list[str] | bool | dict[str, str] | dict[str, set[str]] | dict[str, set[Dependency]] | None
            Variable value as string, list, bool, dict, or None if not found.
        """
        value = self.variables.get(name)
        if value is None:
            return None
        if expand:
            value = self._expand_variables(value, skip_expand or [])
        if not convert:
            return value
        if name == 'SRC_URI':
            return self._parse_src_uri(value)
        if name in ('DEPEND', 'RDEPEND', 'BDEPEND'):
            return self._parse_dependencies(value)
        if integer_to_bool and value in ('0', '1'):
            return value == '1'
        if str_to_bool and value.lower() in ('true', 'false'):
            return value.lower() == 'true'
        if value.startswith('(') and value.endswith(')'):
            inner = value[1:-1].strip()
            items: list[str] = []
            for line in inner.split('\n'):
                items.extend(x.strip() for x in line.split() if x.strip())
            return items
        if '\n' in value or ' ' in value:
            items = []
            for line in value.split('\n'):
                items.extend(x.strip() for x in line.split() if x.strip())
            return items
        return value

    def _expand_variables(self, value: str, skip_expand: Collection[str]) -> str:
        """Expand variable references in a string."""
        def replace_var(match: re.Match[str]) -> str:
            var_name = match.group(1)
            if var_name in skip_expand:
                return match.group(0)
            return self.variables.get(var_name,
                                      f'__{var_name}_VARIABLE_ASSIGNED_BY_ECLASS_OR_IS_UNSET__')

        return re.sub(r'\$\{([A-Z_][A-Z0-9_]*)\}', replace_var, value)

    def _parse_src_uri(self, value: str) -> dict[str, str]:
        """Parse SRC_URI into dict of URI to filename mappings."""
        result = {}
        tokens = value.replace('\n', ' ').split()
        i = 0
        while i < len(tokens):
            if i + 2 < len(tokens) and tokens[i + 1] == '->':
                result[tokens[i]] = tokens[i + 2]
                i += 3
            else:
                uri = tokens[i]
                result[uri] = uri.split('/')[-1]
                i += 1
        return result

    def _parse_dependencies(self, value: str) -> dict[str, set[Dependency]]:
        """Parse dependencies with USE flag conditionals.

        Returns
        -------
        dict[str, set[Dependency]]
            Dict with '' key and USE flag keys mapping to dependency sets.
        """
        result: dict[str, set[Dependency]] = {'': set()}
        tokens = value.replace('\n', ' ').split()
        self._parse_dep_tokens(tokens, 0, len(tokens), '', result)
        return result

    def _parse_dep_tokens(self, tokens: list[str], start: int, end: int, use_context: str,
                          result: dict[str, set[Dependency]]) -> int:
        """Recursively parse dependency tokens with USE flag context."""
        i = start
        while i < end:
            token = tokens[i]
            if token.endswith('?'):
                use_flag = token.rstrip('?')
                if use_context:
                    use_flag = f'{use_context}+{use_flag}'
                if i + 1 < end and tokens[i + 1] == '(':
                    if use_flag not in result:
                        result[use_flag] = set()
                    i += 2
                    paren_count = 1
                    block_start = i
                    while i < end and paren_count > 0:
                        if tokens[i] == '(':
                            paren_count += 1
                        elif tokens[i] == ')':
                            paren_count -= 1
                        i += 1
                    self._parse_dep_tokens(tokens, block_start, i - 1, use_flag, result)
                    continue
            elif token not in ('(', ')'):
                key = use_context if use_context else ''
                if key not in result:
                    result[key] = set()
                result[key].add(self._parse_dependency(token))
            i += 1
        return i

    def _parse_dependency(self, dep_str: str) -> Dependency:
        """Parse a single dependency string into a Dependency object."""
        package = dep_str
        slot = ''
        subslot = ''
        slot_operator = ''
        version_constraint = ''
        version = ''
        use_flags: tuple[str, ...] = ()
        if '[' in dep_str:
            package, use_part = dep_str.split('[', 1)
            use_flags = tuple(use_part.rstrip(']').split(','))
        if ':' in package:
            package, slot_part = package.split(':', 1)
            if '=' in slot_part:
                slot_operator = slot_part
            elif '/' in slot_part:
                slot, subslot = slot_part.split('/', 1)
            else:
                slot = slot_part
        for op in ('>=', '<=', '>', '<', '=', '~'):
            if package.startswith(op):
                version_constraint = op
                package = package[len(op):]
                if '-' in package:
                    parts = package.rsplit('-', 1)
                    if parts[1][0].isdigit():
                        package, version = parts
                break
        return Dependency(package=package,
                          slot=slot,
                          subslot=subslot,
                          slot_operator=slot_operator,
                          version_constraint=version_constraint,
                          version=version,
                          use_flags=use_flags)

    def get_phase(self, name: str) -> EbuildPhase | None:
        """Get a phase function by name."""
        return self.phases.get(name)

    def iter_variables(self) -> Iterator[tuple[str, str]]:
        """Iterate over all variables."""
        yield from self.variables.items()

    def iter_phases(self) -> Iterator[EbuildPhase]:
        """Iterate over all phase functions."""
        yield from self.phases.values()

    def set_variable(self,
                     name: str,
                     value: str | list[str] | bool | int,
                     *,
                     delimited_list: bool = False) -> None:
        """Set a variable value and update content.

        Parameters
        ----------
        name : str
            Variable name.
        value : str | list[str] | bool | int
            New value (bool True becomes '1', int converts to str, lists become arrays).
        delimited_list : bool
            If ``True`` and value is a list, format as a delimited string instead of an array.
        """
        if isinstance(value, bool):
            value = '1' if value else '0'
        elif isinstance(value, int):
            value = str(value)
        elif isinstance(value, list):
            if not delimited_list:
                value = '(\n\t' + '\n\t'.join(str(x) for x in value) + '\n)'
            else:
                value = '"\n\t' + '\n\t'.join(str(x) for x in value) + '"'
        lines = self.content.splitlines()
        i = 0
        while i < len(lines):
            stripped = lines[i].strip()
            if m := re.match(rf'^{re.escape(name)}=(.*)$', stripped):
                old_value = m.group(1).strip()
                needs_quotes = ' ' in value or '$' in value or not value
                if old_value.startswith('('):
                    paren_count = old_value.count('(') - old_value.count(')')
                    end_line = i
                    while paren_count > 0 and end_line + 1 < len(lines):
                        end_line += 1
                        paren_count += lines[end_line].count('(') - lines[end_line].count(')')
                    lines[i:end_line + 1] = [f'{name}={value}']
                elif old_value.startswith('"'):
                    quote_count = old_value.count('"')
                    end_line = i
                    while quote_count % 2 != 0 and end_line + 1 < len(lines):
                        end_line += 1
                        quote_count += lines[end_line].count('"')
                    lines[i:end_line + 1] = [
                        f'{name}="{value}"' if needs_quotes else f'{name}={value}'
                    ]
                else:
                    lines[i] = f'{name}="{value}"' if needs_quotes else f'{name}={value}'
                break
            i += 1
        self.content = '\n'.join(lines)
        self.variables[name] = value

    def set_phase(self, name: str, body: str) -> None:
        """Set or replace a phase function body.

        Parameters
        ----------
        name : str
            Phase function name (e.g., 'src_prepare').
        body : str
            Phase function body content.
        """
        lines = self.content.splitlines()
        if name in self.phases:
            phase = self.phases[name]
            new_lines = [f'{name}() {{'] + [f'\t{line}' for line in body.splitlines()] + ['}']
            lines[phase.line_start:phase.line_end + 1] = new_lines
        else:
            new_lines = ['', f'{name}() {{'] + [f'\t{line}' for line in body.splitlines()] + ['}']
            lines.extend(new_lines)
        self.content = '\n'.join(lines)
        self._parse()

    def save(self) -> None:
        """Save changes to the ebuild file."""
        with open(self.path, 'w') as f:
            f.write(self.content)
            if not self.content.endswith('\n'):
                f.write('\n')
