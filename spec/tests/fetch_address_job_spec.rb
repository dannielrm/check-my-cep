require "rails_helper"

RSpec.describe FetchAddressJob, type: :job do
  describe "#perform_later" do
    let!(:customer) { FactoryBot.create(:customer) }
    let!(:address) { FactoryBot.create(:address, customer: customer) }

    it "queues a job" do
      ActiveJob::Base.queue_adapter = :test

      expect {
        FetchAddressJob.perform_later(address)
      }.to have_enqueued_job
    end

    # I can test if the job request is working fine mocking possible external responses
    # but it's just too much work for the time available
  end
end