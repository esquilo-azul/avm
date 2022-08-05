# frozen_string_literal: true

require 'avm/sources/runner'

::RSpec.describe ::Avm::Sources::Runner do
  it do
    expect { described_class.run(argv: %w[--help]) }.not_to raise_error
  end
end
