require("pg")

class Bounty
  attr_reader :id
  attr_accessor :name, :species, :bounty_value, :danger_level, :last_known_location, :homeworld, :favourite_weapon, :cashed_in, :collected_by

  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]
    @species = options["species"]
    @bounty_value = options["bounty_value"]
    @danger_level = options["danger_level"]
    @last_known_location = options["last_known_location"]
    @homeworld = options["homeworld"]
    @favourite_weapon = options["favourite_weapon"]
    @cashed_in = options["cashed_in"]
    @collected_by = options["collected_by"]
  end

  def save()
    db = PG.connect({ dbname: "cowboys", host: "localhost"})
    sql = "INSERT INTO bounties (name, species, bounty_value, danger_level, last_known_location, homeworld, favourite_weapon, cashed_in, collected_by) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING id;"
    values = [@name, @species, @bounty_value, @danger_level, @last_known_location, @homeworld, @favourite_weapon, @cashed_in, @collected_by]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    db.close()
    @id = result[0]["id"].to_i
  end

  def delete()
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "UPDATE bounties SET (name, species, bounty_value, danger_level, last_known_location, homeworld, favourite_weapon, cashed_in, collected_by) = ($1, $2, $3, $4, $5, $6, $7, $8, $9)"
    values = [@name, @species, @bounty_value, @danger_level, @last_known_location, @homeworld, @favourite_weapon, @cashed_in, @collected_by]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def self.all()
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "SELECT * FROM bounties;"
    db.prepare("all", sql)
    bounties = db.exec_prepared("all")
    db.close()
    return bounties.map {|bounty| Bounty.new(bounty)}
  end


  def self.delete_all()
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "DELETE FROM bounties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.find_by_name(name)
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "SELECT * FROM bounties WHERE name = #{'name'}"
    db.prepare("name", sql)
    results = db.exec_prepared("name")
    db.close()
    @id = results[0]["id"].to_i
    return results.map {|results| Bounty.new(results)}
  end

  def self.find(id)
    db = PG.connect({dbname: "cowboys", host: "localhost"})
    sql = "SELECT id FROM cowboys WHERE id =#{id}"
    db.prepare("find", sql)
    results = db.exec_prepared("id")
    db.close()
    @id = results[0]["id"].to_i
    return results.map {|results| Bounty.new(results)}
  end

end
