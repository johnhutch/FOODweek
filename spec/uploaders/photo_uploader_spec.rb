describe PhotoUploader do

  let(:recipe) { double('recipe') }
  let(:uploader) { PhotoUploader.new(recipe, :photo) }

  before do
    MyUploader.enable_processing = true
    File.open(path_to_file) { |f| uploader.store!(f) }
  end

  after do
    PhotoUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it "scales down a landscape image to be exactly 64 by 64 pixels" do
      expect(uploader.thumb).to have_dimensions(32, 32)
    end
  end

  context 'the hero version' do
    it "scales down a landscape image to fit within 128 by 128 pixels" do
      expect(uploader.hero).to be_no_larger_than(128, 128)
    end
  end

  it "makes the image readable only to the owner and not executable" do
    expect(uploader).to have_permissions(0600)
  end

  it "has the correct format" do
    expect(uploader).to be_format('png')
  end
end
