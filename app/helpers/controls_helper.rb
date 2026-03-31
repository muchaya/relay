module ControlsHelper
  def segmented_controls_for(options)
    tag.div(class: "controls-container", data: {segmented_controls_target: "controlsContainer"}) do
      tag.div(class: "controls", data: { segmented_controls_target: "controls" }) do
        options.each_with_index do |option, index|
          default_selection = index.zero?

          concat(segment(option, default_selection))
        end
      end
    end
  end

  def segment(name, default_selection)
    label = name
    value = name.downcase

    tag.div(class: "segment #{'selected-segment' if default_selection}") do
      concat(
        tag.input(
          type: "radio",
          value: value,
          id: value,
          name: "segmented-controls",
          data: {
            segmented_controls_target: "segment",
            action: "input->segmented-controls#select"
          },
          checked: default_selection
        )
      )
      concat(tag.label(for: value) { label })
    end
  end
end
