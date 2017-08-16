require 'rails_helper'

RSpec.describe City, type: :model do
  include FactoryGirl::Syntax::Methods
  # Rails.logger = Logger.new(STDOUT) in rails_helper.rb
  include_context 'db_cleanup_each', :transaction

  name = "Ann Arbor"
  let(:city) { City.find(@city.id) }

  before(:all) do
    @city = create(:city, name: name )
  end

  describe '#create' do
    subject { city }
    it { is_expected.to be_valid }
    it { is_expected.to be_persisted }
    it { expect(described_class.find(subject.id)).not_to be_nil }
    it { expect(described_class.find(subject.id)).to eq(subject) }
    xit { before_count = described_class.count; subject; expect(described_class.count).to eq(before_count + 1) }
  end

  describe '#name' do
    subject { city.name }
    it { is_expected.not_to be_nil }
    it { is_expected.to eq(name) }
  end
end
