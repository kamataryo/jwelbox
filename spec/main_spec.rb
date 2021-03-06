require 'spec_helper'
require 'tmpdir'

require 'monorepo'

RSpec.describe MonorepoCLI do
  it 'has a version number' do
    expect(MonorepoCLI::VERSION).not_to be nil
  end
end

describe 'Common methods' do
  current = Dir.pwd
  tmp = ''

  before :each do
    tmp = Dir.mktmpdir
    Dir.chdir tmp
  end

  after :each do
    Dir.chdir current
    FileUtils.rm_r tmp
  end

  it 'detects no config file' do
    expect(MonorepoCLI.load_config).to be nil
  end

  it 'detects Monorepofile' do
    open('./Monorepofile', 'w') { |f| f.write({ 'desc' => 'upper' }.to_yaml) }
    config = MonorepoCLI.load_config
    expect(config['desc']).to eq 'upper'
  end
end
