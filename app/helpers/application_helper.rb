module ApplicationHelper
  def formatted_price(price)
    sprintf("%.2f", price)
  end

  def form_step_progress_percentages
    current_step = wizard_steps.find_index(step) + 1
    total_steps = wizard_steps.size
    pending_steps = total_steps - current_step

    completed = number_to_percentage((current_step.to_f / total_steps) * 100)

    pending = if pending_steps.zero?
      number_to_percentage(0)
    else
      number_to_percentage((pending_steps.to_f / total_steps) * 100)
    end

    { completed: completed, pending: pending }
  end
end
