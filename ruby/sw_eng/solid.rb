# Ground rules
# - Only mock classes I own
# - Don't mock/stub classes under test


describe PatentJob do
  it "should download the csv file from the ftp server" do
    @job = PatentJob.new
    f = File.read(@job.download_file)

  end
end
