# frozen_string_literal: true

RSpec.shared_context 'with_launcher' do
  let(:launcher_controller) { Avm::Rspec::LauncherController.new }

  before do
    Avm::Launcher::Context.current = launcher_controller.new_context
    launcher_controller.remotes_dir = Dir.mktmpdir
    allow(ProgressBar).to receive(:create).and_return(double.as_null_object)
  end

  delegate :application_source_path, :context_set, :init_git, :init_remote, :temp_context,
           :projects_root, :projects_root=, :touch_commit, to: :launcher_controller
end
