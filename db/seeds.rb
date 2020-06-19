require "open-uri"
require 'nokogiri'

def scrape(url, railroad)
  query_page = Nokogiri::HTML(open(url))
  train_tables = query_page.css("table.wikitable")
  symbol_descriptions = query_page.css("h3 span.mw-headline")
  counter = -1
  train_tables.each do |table|
    table.children.each do |row|
      if !row.children[1].nil? && row.children[1].text.strip == "Symbol"
        counter+=1
        next
      end
      if row.text.strip != ""
        Train.create({
          railroad: railroad,
          symbol: row.children[1] ? row.children[1].text.strip : nil, 
          origin: row.children[3] ? row.children[3].text.strip : nil, 
          destination: row.children[5] ? row.children[5].text.strip : nil, 
          frequency: row.children[7] ? row.children[7].text.strip : nil, 
          notes: row.children[9] ? row.children[9].text.strip : nil,
          description: symbol_descriptions[counter].text
          })
      end
    end
  end
end

def scrape_csx(url, railroad)
  query_page = Nokogiri::HTML(open(url))
  train_tables = query_page.css("table.wikitable")
  symbol_descriptions = query_page.css("span.mw-headline")
  counter = 0
  train_tables.each do |table|
    table.children.each do |row|
      if !row.children[1].nil? && row.children[1].text.strip == "Q704"
      end
      if !row.children[1].nil? && row.children[1].text.strip == "Symbol"
        counter+=1
        next
      end
      if row.text.strip != ""
        Train.create({
          railroad: railroad,
          symbol: row.children[1] ? row.children[1].text.strip : nil, 
          origin: row.children[3] ? row.children[3].text.strip : nil, 
          destination: row.children[5] ? row.children[5].text.strip : nil, 
          frequency: row.children[7] ? row.children[7].text.strip : nil, 
          notes: row.children[9] ? row.children[9].text.strip : nil,
          description: symbol_descriptions[counter].text
          })
      end
    end
  end
end

def scrape_kcs(url, railroad)
  query_page = Nokogiri::HTML(open(url))
  train_tables = query_page.css("table.wikitable")
  train_tables.each do |table|
    table.children.each do |row|
      if row.text.strip != ""
        Train.create({
          railroad: railroad,
          symbol: row.children[1] ? row.children[1].text.strip : nil, 
          origin: row.children[3] ? row.children[3].text.strip : nil, 
          destination: row.children[5] ? row.children[5].text.strip : nil, 
          frequency: row.children[7] ? row.children[7].text.strip : nil, 
          notes: row.children[9] ? row.children[9].text.strip : nil
          })
      end
    end
  end
end


up_url = "http://railroadfan.com/wiki/index.php/UP_Train_Symbols"
bnsf_url = "http://railroadfan.com/wiki/index.php/BNSF_Train_Symbols"
ns_url = "http://railroadfan.com/wiki/index.php/NS_Train_Symbols"
csx_url = "http://railroadfan.com/wiki/index.php/CSX_Train_Symbols"
cp_url = "http://railroadfan.com/wiki/index.php/CP_Train_Symbols"
cn_url = "http://railroadfan.com/wiki/index.php/CN_Train_Symbols"
kcs_url = "http://railroadfan.com/wiki/index.php/KCS_Train_Symbols"

scrape(up_url, "UP")
puts "seeded UP"
scrape(bnsf_url, "BNSF")
puts "seeded BNSF"
scrape(ns_url, "NS")
puts "seeded NS"
scrape_csx(csx_url, "CSX")
puts "seeded CSX"
scrape(cp_url, "CP")
puts "seeded CP"
scrape(cn_url, "CN")
puts "seeded CN"
scrape_kcs(kcs_url, "KCS")
puts "seeded KCS"

# row.children[1].text.strip - symbol
# row.children[3].text.strip - origin
# row.children[5].text.strip - destination
# row.children[7].text.strip - frequency
# row.children[9].text.strip - notes