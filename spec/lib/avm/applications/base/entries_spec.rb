# frozen_string_literal: true

require 'avm/applications/base'

RSpec.describe ::Avm::Applications::Base do
  include_examples 'entries_values', __FILE__, {
    'app0' => {
      'name' => 'Application 0',
      'organization' => nil
    },
    'app1' => {
      'name' => nil,
      'organization' => 'org1'
    }
  }

  # @return [Avm::Entries::Base]
  def build_instance(instance_id)
    described_class.new(instance_id)
  end
end
