#import "typyst-template/template.typ": project
#import "@preview/dashy-todo:0.0.2": todo

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
logo: "ulb_logo.jpg",
)

= Introduction
#lorem(200)