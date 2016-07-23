class PatentJob
  def run
    temp = download_file
    rows = parse(temp)
    update_patents(rows)
  end

  def download_file
    temp = Tempfile.new('patents')
    tempname = temp.path
    temp.close
    Net::FTP.open('localhost', 'foo', 'foopw') do |ftp|
      ftp.getbinaryfile('Public/prod/patents.csv', tempname)
    end
    tempname
  end

  def parse(temp)
    FasterCSV.read(temp, :headers => true)
  end

  def update_patents(rows)
    Patent.connection.transaction {
      Patent.delete_all
      rows.each {|r| Patent.create!(r.to_hash)}
    }
  end
end



# what if ftp host/login/password changes?
# What if I need to create another job like this?

# what if i don't want to ftp a file in every test?
