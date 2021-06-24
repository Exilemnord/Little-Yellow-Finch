
require "hashdiff"
require "ostruct"

#class Hash
    #def deep_find(key)
      #key?(key) ? self[key] : self.values.inject(nil) {|memo, v| memo ||= v.deep_find(key) if v.respond_to?(:deep_find) }
    #end
#end

class Hash
    def without(*keys)
      cpy = self.dup
      keys.each { |key| cpy.delete(key) }
      cpy
    end
end



class Animal
    attr_accessor :traits
    def initialize(traits: {})
        @traits = traits 
    end
    
    # This is the method engine that assembles animals and assigns instance variables and methods

    def set_traits(*args)
        @traits = Traits.all.map {|key,value| [key, value.select {|k,v| 
            args.include? k}]}.to_h 
            self.traits.each_pair do |key, value|       
                instance_variable_set("@#{key}", value)
                self.class.instance_eval { attr_accessor key.to_sym, :name, :traits }
            end       
    end

    def self
        self.complete
    end

    def complete
        traits.merge!(extra_traits)
    end
end

#These subclasses could be replaced by passing location and lives on through to Traits.new along with skin etc.
#and then just specifying the keys in the args along with skin etc.  This was just an inheritance exercise.  

class Land_Animal < Animal
    attr_accessor :name, :location, :lives_on, :extra_traits, :traits
    def initialize(name: '', extra_traits: {}, location: {location:{loc1: 'Land Animal'}}, lives_on: {lives_on: {lo1: 'Land'}}, traits: []) 
        @name = name
        @location = location.map {|k,v| v}
        @lives_on = lives_on.map {|k,v| v}
        @extra_traits = extra_traits.merge!(location).merge!(lives_on)
        @traits = *traits
        self.set_traits(*traits)

    end
end

class Water_Animal < Animal
    attr_accessor :name, :location, :lives_on, :extra_traits, :traits
    def initialize(name: '', extra_traits: {}, location: {location:{loc3: 'Water Animal'}}, lives_on: {lives_on: {lo: 'Water'}}, traits: []) 
        @name = name
        @location = location.map {|k,v| v}
        @lives_on = lives_on.map {|k,v| v}
        @extra_traits = extra_traits.merge!(location).merge!(lives_on)
        @traits = *traits
        self.set_traits(*traits)

    end
end

class Areal_Animal < Animal
    attr_accessor :name, :location, :lives_on, :extra_traits, :traits
    def initialize(name: '', extra_traits: {}, location: {location:{loc2: 'Areal Animal'}}, lives_on: {lives_on: {lo2: 'Air'}}, traits: []) 
        @name = name
        @location = location.map {|k,v| v}
        @lives_on = lives_on.map {|k,v| v}
        @extra_traits = extra_traits.merge!(location).merge!(lives_on)
        @traits = *traits
        self.set_traits(*traits)

    end
end

class Traits
    attr_accessor :traits
    def initialize(traits: {})
        @traits = traits.map {|types| types.types.to_h}.reduce({}, :merge!)
        self.traits.each_pair do |key, value|       
            instance_variable_set("@#{key}", value)
            self.class.instance_eval { attr_accessor key.to_sym }
        end
    end

    def self.all
        ObjectSpace.each_object(self).map {|traits| traits.traits.to_h}.reduce({}, :merge!) 
    end
end

class Trait
    attr_accessor :name, :types
    def initialize(name:, types: {})
        @name = name
        @types = OpenStruct.new(types)
    end
    def get_types
        types.to_h.sort
    end

    def self.all
      ObjectSpace.each_object(self).to_a.map {|types| types.types.to_h}.reduce({}, :merge!)
    end

    def hash_of_types
      instance_variables.map do |var| 
        [var[1..-1].to_sym, instance_variable_get(var)]
      end.to_h
    end

end

#Dynamic list of Trait types


size = Trait.new(name: 'size', types: {size: {s1: "Enormous", s2: "Large", s3: "Average", s4: "Small", 
    s5: "Little", s6: "Tiny"}})
speed = Trait.new(name: 'speed', types: {speed: {sp1: "lethargic", sp2: "slow", sp3: "sauntering", sp4: 'scurrying', sp5: "quick",
     sp6: "fast", sp7: "gliding", sp8: "fluttering", sp9: "darting"}})  
motion = Trait.new(name: 'motion', types: {motion: {mo1: "pad footed", mo2: "spring footed", mo3: 'claw footed', 
    mo4: 'web footed', mo5: 'hoofed', mo6: 'flippered',mo7: 'finned', mo8: 'serpentine', mo9: 'single winged', 
    mo10: 'multi winged', mo11: 'drifting', mo12: "tentacled", mo13: "multi-footed", mo14: 'contracting'}})     
mouth = Trait.new(name: 'mouth' , types: {mouth: {m1: "fanged", m2: "lipped", m3: "billed", m4: "multi-toothed", 
    m5: "razor-toothed", m6: "longue-tongued", m7: "flat toothed", m8: "fish mouthed", m9: "pincered", m10: "beaked", 
    m11: "tusked", m12: "mouthless"}}) 
skin = Trait.new(name: 'skin', types: {skin: {sk1: "furry", sk2: "short haired", sk3: "leathery", sk4: "scaled",
     sk5: "feathered", sk6: "hard shelled", sk7: "blubbery", sk8: "skinless"}})
colour = Trait.new(name: 'colour', types: {colour: {c1: "white", c2: "yellow", c3: "brown", c4: "green",
     c5: "blue_grey", c6: "grey", c7: "spotted", c8: "technicolour", c9: "black", c10: "red", c11: "blue", c12: "striped", 
     c13: 'patchy', c14: 'translucent'}})    
preferred_temp = Trait.new(name: 'preferred temperature', types: {preferred_temp: {t1: "frozen", t2: "cold", 
    t3: "temperate", t4: "mediterranean", t5: "warm", t6: "hot", t7: "scorching"}})
diet = Trait.new(name: "diet", types: {diet: {d1: 'meat eating', d2: 'omnivorous', d3: 'vegetarian', d4: 'fish eating', 
    d5: 'insect eating', d6: 'sugar eating'}})
#extra traits

location = Trait.new(name: 'location', types: {location: {loc1: "Land Animal", loc2: "Areal animal", loc3: "Water animal"}})
lives_on = Trait.new(name: 'lives on', types: {lives_on: {lo1: "land", lo2: "air", lo3: "water"}})

    
#send above Trait list to Traits (could also send location and lives_on here)

animal_traits = Traits.new(traits: [skin, mouth, colour, size, preferred_temp, speed, motion, location,lives_on, diet])

  
#Areal Animal list
    
finch = Areal_Animal.new(name: "Finch", traits:[:s5, :sp8, :mo9, :m10, :sk5, :c2, :t3, :d3])
vulture = Areal_Animal.new(name: "Vulture", traits: [:s3, :sp7, :mo9, :m10, :sk5, :c6, :t5, :d1])
albatross = Areal_Animal.new(name: "Albatross", traits: [:s3, :sp7, :mo9, :m10, :sk5, :c1, :t3, :d4])
bat = Areal_Animal.new(name: "Bat", traits: [:s5, :sp8, :mo9, :m4, :sk3, :c9, :t4, :d5])
dragonfly = Areal_Animal.new(name: "Dragonfly", traits: [:s6, :sp6, :mo10, :m9, :sk6, :c14, :t5, :d5])
puffin = Areal_Animal.new(name: "Puffin", traits: [:s4, :sp7, :mo9, :m10, :sk5, :c8, :t2, :d4])
falcon= Areal_Animal.new(name: "Falcon", traits: [:s4, :sp6, :mo9, :m10, :sk5, :c3, :t3, :d1])
moth= Areal_Animal.new(name: "Moth", traits: [:s6, :sp8, :mo10, :m9, :sk1, :c9, :t5, :d6])
butterfly = Areal_Animal.new(name: "Butterfly", traits: [:s6, :sp8, :mo10, :m9, :sk1, :c8, :t5, :d6]) 
condor = Areal_Animal.new(name: "Condor", traits: [:s3, :sp7, :mo9, :m10, :sk5, :c9, :t4, :d1])
pidgeon = Areal_Animal.new(name: "Pidgeon", traits: [:s5, :sp8, :mo9, :m10, :sk5, :c6, :t3, :d3])
    
#Water Animal list

walrus = Water_Animal.new(name: 'Walrus', traits: [:s2, :sp1, :mo6, :m11, :sk7, :c6, :t1, :d4]) 
whale = Water_Animal.new(name: 'Whale', traits: [:s1, :sp7, :mo7, :m4, :sk3, :c5, :t2, :d4])
shark = Water_Animal.new(name: 'Shark', traits: [:s2, :sp7, :mo7, :m5, :sk3, :c5, :t4, :d1])
jellyfish = Water_Animal.new(name: 'Jellyfish', traits: [:s4, :sp1, :mo11, :m12, :sk7, :c14, :t4, :d4])
urchin = Water_Animal.new(name: 'Urchin', traits: [:s5, :sp2, :mo14, :m10, :sk6, :c10, :t2, :d4])
sealion = Water_Animal.new(name: 'Sealion', traits: [:s2, :sp7, :mo6, :m4, :sk7, :c6, :t2, :d4])
cod = Water_Animal.new(name: 'Cod', traits: [:s4, :sp5, :mo7, :m8, :sk4, :c3, :t2, :d4])
eel = Water_Animal.new(name: 'Eel', traits: [:s4, :sp7, :mo8, :m5, :sk3, :c9, :t4, :d4])
flounder = Water_Animal.new(name: "Flounder", traits: [:s4, :sp8, :mo7, :m8, :c7, :t2, :d4])
prawn= Water_Animal.new(name: "Prawn", traits: [:s6, :sp4, :mo13, :m9, :sk6, :c8, :t3, :d3])
grouper = Water_Animal.new(name: "Grouper", traits: [:s2, :sp7, :mo7, :m8, :sk4, :c6, :t3, :d4])

#Land Animal list

snake = Land_Animal.new(name: 'Snake', traits: [:s4, :sp5, :mo8, :m6, :sk4, :c4, :t6, :d1])
pangolin = Land_Animal.new(name: 'Pangolin',traits: [:s4, :sp4, :mo3, :m6, :sk4, :c10, :t5, :d5])
aligator = Land_Animal.new(name: 'Aligator',traits: [:s2, :sp1, :mo3, :m4, :sk4, :c4, :t6, :d1])
scorpion = Land_Animal.new(name: 'Scorpion',traits:  [:s5, :sp2, :mo13, :m9, :sk6, :c2, :t7, :d5])
bushbaby = Land_Animal.new(name: 'Bushbaby',traits: [:s4, :sp2, :mo2, :m2, :sk2, :c3, :t5, :d3])
ocelot = Land_Animal.new(name: "Ocelot", traits: [:s4, :sp5, :mo3, :m4, :sk2, :c12, :t5, :d1])
mongoose = Land_Animal.new(name: 'Mongoose',traits: [:s4, :sp4, :mo1, :m4, :sk2, :c3, :t5, :d1])
lynx = Land_Animal.new(name: 'Lynx',traits: [:s3, :sp6, :mo3, :m1, :sk1, :c3, :t2, :d1])
antelope = Land_Animal.new(name: 'Antelope',traits: [:s3, :sp6, :mo5, :m2, :sk2, :c3, :t5, :d3])
bear = Land_Animal.new(name: "Bear", traits: [:sk1, :m1, :c3, :s2, :t2, :sp3, :mo3, :d2])
jackal = Land_Animal.new(name: 'Jackal', traits: [:sk2, :m1, :c3, :s3, :t5, :sp5, :mo3, :d1])
donkey = Land_Animal.new(name: 'Donkey', traits: [:sk2, :m2, :c6, :s2, :t4, :sp3, :mo5, :d3])
groundhog = Land_Animal.new(name: 'Groundhog', traits: [:sk2, :m2, :c6, :s4, :t3, :sp4, :mo3, :d3])
tortoise = Land_Animal.new(name: 'Tortoise', traits: [:sk6, :m10, :c5, :s4, :sp1, :t6, :mo3, :d3])
salamander = Land_Animal.new(name: 'Salamander', traits:[:s6, :sp9, :mo4, :m6, :sk4, :c4, :t6, :d5])
caribou = Land_Animal.new(name: 'Caribou', traits: [:s3, :sp3, :mo5, :m2, :sk2, :c3, :t2, :d3])
jaguar = Land_Animal.new(name: 'Jaguar', traits: [:s3, :sp5, :mo3, :m1, :sk2, :c7, :t6, :d1])
centipede = Land_Animal.new(name: 'Centipede',traits: [:s6, :sp4, :mo13, :m9, :sk6, :c10, :t6, :d5])
spider = Land_Animal.new(name: 'Spider', traits: [:s6, :sp9, :mo13, :m9, :sk6, :c9, :t6, :d5])
gecko = Land_Animal.new(name: 'Gecko', traits: [:s5, :sp4, :mo4, :m6, :sk4, :c4, :t6, :d5])
toad = Land_Animal.new(name: 'Toad', traits: [:s4, :sp1, :mo2, :m6, :sk3, :c4, :t4, :d5])
aardvark = Land_Animal.new(name: 'Aardvark',traits: [:s3, :sp4, :mo3, :m6, :sk2, :c3, :t5, :d5])
beetle = Land_Animal.new(name: 'Beetle', traits: [:s6, :sp4, :mo13, :m9, :sk6, :c9, :t3, :d3])
mole = Land_Animal.new(name: 'Mole', traits: [:s5, :sp4, :mo3, :m4, :sk2, :c6, :t3, :d5])
racoon = Land_Animal.new(name: "Racoon", traits: [:s4, :sp3, :mo3, :m4, :sk1, :c13, :t3, :d2])














#bear.get_traits(:skin)
#bear.get_traits(:sk2, :m1, :c1,:s1, :t1, :sp1, :mo)
#bear = Animal.new(name: name[:n1], motion: motion[:m1], skin: skin[:sk1], mouth: mouth[:m7], colour: colour[:c3], size: size[:s3], preferred_temp: preferred_temp[:t3], speed: speed[:sp3])



#p flatten_hash_from(traits.traits)
#p animal_traits.traits[:skin]

#p skin.types.skin[:sk1]
#p traits.traits[0].types.sk4
#p traits.traits[0].get_types
#p Trait.all#.map {|keys,value| keys.keys.to_h}
#p location.get_types
#p traits.traits.traits_to_hash
#p animal_traits.traits
#p animal_traits.traits[:skin][:sk2]
#p skin.types
#p bear.traits
#p Traits.all
#p Animal.traits
#p motion.types
#p bear.traits
#p bear.lives_on
#p bear.traits
#p bear.location
#p bear.lives_on
p walrus.complete
p "_______________"
p walrus.traits
p "_______________"
p walrus
#p bear.combined
#p bear.traits
#p bear.lives_on

#p bear.combine
#p Animal.methods
#p bear.instance_variables
#p bear.instance_variables
#p Traits.all&.dig(:skin,:sk1)  #This will return the value in a nested hash
#p animal_traits.traits
#p bear.mouth
#*args = (:skin)
#p Traits.all&.dig(*args)
#p Traits.all.fetch(:lives_on).fetch(:lo2)