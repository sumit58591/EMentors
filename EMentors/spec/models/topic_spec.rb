require 'rails_helper'
RSpec.describe Topic, type: :model do
    subject { create(:topic) }
    
    it { is_expected.to belong_to(:course) }
    it { is_expected.to validate_presence_of(:topic_name) }
    it { is_expected.to validate_presence_of(:topic_description) }
    it { is_expected.to validate_presence_of(:post_video) }
end