#import "typyst-template/template.typ": project

#show: project.with(
  title: "\todo{Title}",
  authors: (
    (
      name: "Kevin VANDERVAEREN",
      status: "Author",
      affiliation: "ULB",
    ),
    (
      name: "Yannick MOLINGHEN",
      status: "Unknown",
    ),
    (
      name: "Prof. Tom LENAERTS",
      status: "Supervisor",
    )
  ),
logo: "typyst-template/logo.png",
abstract: |
  \todo{Abstract}
  \todo{Keywords}
)

= Introduction

\lipsum[1-2]