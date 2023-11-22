# frozen_string_literal: true

require 'avm/launcher/context'
require 'avm/launcher/instances/base'

RSpec.describe Avm::Launcher::Instances::Base do
  let(:fixtures_dir) { __dir__.to_pathname.join('base_spec_files') }
  let(:launcher_context) do
    Avm::Launcher::Context.current = Avm::Launcher::Context.new(
      projects_root: fixtures_dir.join('projects').to_path,
      settings_file: fixtures_dir.join('settings.yaml').to_path,
      cache_root: Dir.mktmpdir
    )
  end

  before do
    allow(ProgressBar).to receive(:create).and_return(double.as_null_object)
    Avm::Launcher::Context.current = launcher_context
  end

  describe '#options' do
    context 'when instance is "avm-tools_stub"' do
      let(:instance) { Avm::Launcher::Context.current.instance('/avm-tools_stub') }

      it { expect(instance).to be_a(described_class) }
      it { expect(instance.options.git_current_revision).to eq('origin/master') }
      it { expect(instance.options.git_publish_remote).to eq('publish') }
      it { expect(instance.publishable?).to be(true) }
    end

    context 'when instance is "ruby_gem_stub"' do
      let(:instance) { Avm::Launcher::Context.current.instance('/ruby_gem_stub') }

      before do
        instance.application.entry('publishable').write(false)
      end

      it { expect(instance.options.git_current_revision).to eq('git_current_revision_setted') }
      it { expect(instance.options.git_publish_remote).to eq('git_publish_remote_setted') }
      it { expect(instance.publishable?).to be(false) }
    end
  end
end
