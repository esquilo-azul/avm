# frozen_string_literal: true

require 'eac_fs/comparator'
require 'eac_ruby_utils/core_ext'

RSpec.shared_examples 'avm_source_generated' do |spec_file, stereotype, options = {}|
  fixtures_dir = Pathname.new('base_spec_files').expand_path(File.dirname(spec_file))

  fixtures_dir.children.select(&:directory?).each do |target_dir|
    context "when target is \"#{target_dir.basename}\"" do
      let(:source) { avm_source(stereotype, options.merge(target_basename: target_dir.basename)) }

      it do
        expect(fs_comparator.build(source.path)).to eq(fs_comparator.build(target_dir))
      end
    end
  end

  # @return [EacFs::Comparato]
  def fs_comparator
    EacFs::Comparator.new.rename_file('.gitignore', '_gitignore')
  end
end
