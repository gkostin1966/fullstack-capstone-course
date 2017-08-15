require 'rails_helper'

RSpec.describe City, type: :model do
  # Rails.logger = Logger.new(STDOUT) in rails_helper.rb
  include_context 'db_cleanup_each', :transaction

  describe '#create' do
    subject { described_class.create }
    it { is_expected.to be_valid }
    it { is_expected.to be_persisted }
    it { expect(described_class.find(subject.id)).not_to be_nil }
    it { expect(described_class.find(subject.id)).to eq(subject) }
    it { before_count = described_class.count; subject; expect(described_class.count).to eq(before_count + 1) }
  end

  describe '#name' do
    let(:name) { "name" }
    subject { described_class.create(name: name).name }
    it { is_expected.not_to be_nil }
    it { is_expected.to eq(name) }
  end
end
