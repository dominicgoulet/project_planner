module ApplicationHelper
  class MenuItem
    attr_reader :label, :path, :active

    def initialize(label:, path:, active:)
      @label = label
      @path = path
      @active = active
    end

    def css_classes
      if @active
        'bg-indigo-700 text-white rounded-md py-2 px-3 text-sm font-medium'
      else
        'text-white hover:bg-indigo-500 hover:bg-opacity-75 rounded-md py-2 px-3 text-sm font-medium'
      end
      # <!-- Current: "bg-gray-800 text-white", Default: "text-gray-400 hover:text-white hover:bg-gray-800" -->
    end
  end

  MAIN_MENU_ITEMS = [
    { label: 'Dashboard', path: Rails.application.routes.url_helpers.root_path, controllers: %w[dashboard] },
    { label: 'Reports', path: Rails.application.routes.url_helpers.reports_path, controllers: %w[reports] },
    { label: 'Expenses', path: Rails.application.routes.url_helpers.expenses_path, controllers: %w[expenses] },
    { label: 'Tasks', path: Rails.application.routes.url_helpers.tasks_path, controllers: %w[tasks] },
    { label: 'Suppliers', path: Rails.application.routes.url_helpers.suppliers_path, controllers: %w[suppliers] },
    { label: 'Steps', path: Rails.application.routes.url_helpers.steps_path, controllers: %w[steps] },
    { label: 'Materials', path: Rails.application.routes.url_helpers.materials_path, controllers: %w[materials] },
    { label: 'Payment methods', path: Rails.application.routes.url_helpers.payment_methods_path, controllers: %w[payment_methods] },
  ].freeze

  def main_menu
    MAIN_MENU_ITEMS.map do |item|
      MenuItem.new(
        label: item[:label],
        path: item[:path],
        active: (item[:controllers] || []).include?(params[:controller])
      )
    end
  end

  def tasks_select_options
    Task.all.collect { |t| [ "[#{t.supplier.name}] #{t.name}", t.id ] }.sort
  end

  def materials_select_options
    Material.all.collect { |t| [ "[#{t.supplier.name}] #{t.name}", t.id ] }.sort
  end

  def suppliers_select_options
    Supplier.all.collect { |s| [ s.name, s.id ] }
  end

  def steps_select_options
    Step.all.collect { |s| [ s.name, s.id ] }
  end

  def payment_methods_select_options
    PaymentMethod.all.collect { |s| [ s.name, s.id ] }
  end

  def color_options
    %w[
      slate
      gray
      zinc
      neutral
      stone
      red
      orange
      amber
      yellow
      lime
      green
      emerald
      cyan
      teal
      sky
      blue
      indigo
      violet
      purple
      fuschia
      pink
      rose
  ].sort
  end

  def format_amount(amount)
    number_to_currency(amount, unit: '$ ')
  end
end
