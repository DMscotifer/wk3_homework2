require("pry-byebug")
require_relative("./models/bounties.rb")

bounty1 = Bounty.new({
  "name" => "Malcolm Reynolds",
  "species" => "Human",
  "bounty_value" => 25000,
  "danger_level" => "Extremely dangerous",
  "last_known_location" => "Ariel",
  "homeworld" => "Shadow",
  "favourite_weapon" => "Liberty Hammer .38 caliber revolver",
  "cashed_in" => false,
  "collected_by" => nil,
  });

  bounty1.save()

  bounty2 = Bounty.new({
    "name" => "River Tam",
    "species" => "Human",
    "bounty_value" => 100000,
    "danger_level" => "Do not approach",
    "last_known_location" => "Ariel",
    "homeworld" => "Osiris",
    "favourite_weapon" => "Unarmed",
    "cashed_in" => true,
    "collected_by" => "The Operative",
    });

  bounty2.save()

  bounty = Bounty.all()

binding.pry
nil
