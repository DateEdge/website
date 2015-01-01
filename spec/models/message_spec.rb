require "spec_helper"
describe Message do
  let(:message) { create(:message) }
  describe 'notify' do
    it 'pings resque' do
      expect(Resque).to receive(:enqueue).with(NotificationJob, :new_message, message.id)
      message.notify
    end
  end
end
