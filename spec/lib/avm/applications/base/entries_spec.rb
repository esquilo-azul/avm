# frozen_string_literal: true

require 'avm/applications/base'

RSpec.describe ::Avm::Applications::Base do
  include_examples 'entries_values', __FILE__, {
    'app0' => {
      'name' => 'Application 0',
      'organization' => nil,
      'scm.id' => 'app1',
      'scm.type' => 'ScmX',
      'scm.url' => 'http://nowhere.net/anypath',
      'scm.repos_path' => 'mygroup/app0'
    },
    'app1' => {
      'name' => nil,
      'organization' => 'org1',
      'scm.id' => nil,
      'scm.type' => 'ScmX',
      'scm.url' => 'http://nowhere.net/anypath',
      'scm.repos_path' => 'mygroup'
    }
  }

  # @return [Avm::Entries::Base]
  def build_instance(instance_id)
    described_class.new(instance_id)
  end
end
