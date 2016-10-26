require "spec_helper"

describe GoogleTranslater do
  it 'has a version number' do
    expect(GoogleTranslater::VERSION).not_to be nil
  end

  it 'should recognise the Translater class' do
    g = Translater.new
    expect(g).to be_a Translater
  end
end
