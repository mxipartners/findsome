@drag_and_drop_options =
  items: ".item"
  axis: "y"
  opacity: 0.7
  delay: 100
  refreshPositions: true
  revert: true
  helper: "clone"
  scroll: true
  scrollSensitivity: 50
  scrollSpeed: 35
  start: (event, ui) -> $(ui.helper).addClass("dragging")
  stop: (event, ui) -> $(ui.item).removeClass("dragging")
