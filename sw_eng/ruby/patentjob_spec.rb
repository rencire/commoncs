# Ground rules
# - Only mock classes I own
# - Don't mock/stub classes under test


describe PatentJob do
  it "should download the csv file from the ftp server" do
    @job = PatentJob.new
    f = File.read(@job.download_file)
    expect(f).to have(250).characters
    expect(f.include?("just 3 minutes")).to be_true
  end

  it "should replace existing patents with new patents" do
    downldr = mock("Downloader")
    f = fixture_path + '/patents.csv'
    expect(downldr).to receive(:download_file).once.and_return(f)

    @job = PatentJob.new
    @job.run
    Patent.find(:all).should have(3).rows
    expect(Patent.find_by_name('Anti-Gravity Simulator')).to be
    expect(Patent.find_by_name('Exo-Skello Jello')).to be
    expect(Patent.find_by_name('Nap Compressor')).to be
  end
end



