#!/usr/bin/env python3
"""Regenerate profiles/use.local.desc from every metadata.xml in the overlay."""
from pathlib import Path
from xml.etree import ElementTree

root = Path(__file__).resolve().parent.parent
descriptions = {}
for metadata in root.glob('*/*/metadata.xml'):
    pkg = f'{metadata.parent.parent.name}/{metadata.parent.name}'
    for flag in ElementTree.parse(metadata).getroot().findall('./use/flag'):
        # itertext() keeps <pkg>/<cat> content inline; split/join collapses wrapped lines.
        # Flags repeated with different restrict= keep the last one, like egencache.
        descriptions[f'{pkg}:{flag.get("name")}'] = ' '.join(''.join(flag.itertext()).split())
(root / 'profiles/use.local.desc').write_text(''.join(
    f'{k} - {descriptions[k]}\n' for k in sorted(descriptions)))
