require 'spec_helper'

describe Credential do
  let(:credential) { create(:credential) }
  describe '.validates' do
    it 'is valid' do
      expect(credential.valid?).to eq true
    end
    it 'is invalid without provider' do
      credential.provider_id = nil
      expect(credential.valid?).to eq false
    end
    it 'is invalid without a token' do
      credential.token = nil
      expect(credential.valid?).to eq false
    end
  end

  describe '#expires?' do
    it 'is false' do
      expect(credential.expires?).to eq false
    end
  end
end
