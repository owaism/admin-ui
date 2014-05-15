require_relative 'base_tab'
require 'date'

module AdminUI
  class ComponentsTab < AdminUI::BaseTab
    def do_items
      components = @varz.components

      # components have to exist.  Other record types are optional
      return result unless components['connected']

      items = []

      components['items'].each do |component|
        row = []

        row.push(component['name'])

        data = component['data']

        row.push(data['type'])

        if data['index']
          row.push(data['index'])
        else
          row.push(nil)
        end

        row.push(component['connected'] ? 'RUNNING' : 'OFFLINE')

        if data['start']
          row.push(DateTime.parse(data['start']).rfc3339)
        else
          row.push(nil)
        end

        row.push(component)
        row.push(component['uri'])

        items.push(row)
      end

      result(items, (0..4).to_a, [0, 1, 3, 4])
    end
  end
end
