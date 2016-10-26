require "spec_helper"

describe Translater do
  describe 'language_map' do
    it 'should be a hash' do
      expect(Translater.language_map).to be_a Hash
    end
  end
  describe 'translate' do
    it 'should initialize nicely' do
      expected = "\xCE\xA7\xCE\xB1\xCE\xAF\xCF\x81\xCE\xB5\xCF\x84\xCE\xB5"
      expect(Translater.translate('hello', 'en', 'el')).to eq expected 
    end
  end
end
