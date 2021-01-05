from typing import Any, Dict, Literal, Sequence, TypedDict


class DBAPI:
    def aux_get(
        self, catpkg: str,
        keys: Sequence[Literal['DEFINED_PHASES', 'DEPEND', 'EAPI', 'HDEPEND',
                               'HOMEPAGE', 'INHERITED', 'IUSE', 'KEYWORDS',
                               'LICENSE', 'PDEPEND', 'PROPERTIES', 'PROVIDE',
                               'RDEPEND', 'REQUIRED_USE', 'repository',
                               'RESTRICT', 'SRC_URI', 'SLOT']]
    ) -> Sequence[str]:
        ...

    def xmatch(self,
               level: Literal['bestmatch-visible', 'match-all-cpv-only',
                              'match-all', 'match-visible', 'minimum-all',
                              'minimum-visible', 'minimum-all-ignore-profile'],
               catpkg: str) -> Sequence[str]:
        ...


class PortageTree:
    dbapi: DBAPI


class DBRootDict(TypedDict):
    bintree: Any
    porttree: PortageTree
    virtuals: Any


db: Dict[str, DBRootDict]
root: str
