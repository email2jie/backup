Pry.config.editor = 'vim'

Dir[File.expand_path("./*.rb")].each do |file|
    load file
end

def q
    exit
end

