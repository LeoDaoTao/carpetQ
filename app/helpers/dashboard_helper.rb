module DashboardHelper
  def render_name_or_company(appointment)
    if appointment.customer.present?
      if appointment.customer.first_name? && appointment.customer.last_name?
        return "#{appointment.customer.first_name} #{appointment.customer.last_name}"
      else
        return 'Appointment'
      end
    elsif appointment.description?
      return appointment.description
    else
      return 'Appointment'
    end
  end

  def render_address(appointment)
    if appointment.customer.present?
      return "#{appointment.customer.address}, #{appointment.customer.city}, #{appointment.customer.state} #{appointment.customer.zip}"
    elsif appointment.city?
      return appointment.city
    else
      return ''
    end
  end

  def link_to_create_or_edit_invoice(event)
    if event.invoiced?
      return link_to 'Edit Invoice', edit_invoice_path(event.invoice_id)
    else
      return link_to "Create Invoice", new_invoice_path(event_id: event.id)
    end
  end
end
