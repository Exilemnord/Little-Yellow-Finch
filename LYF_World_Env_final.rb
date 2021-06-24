require "ostruct"
require "hashdiff"
require "timers"
require "deep_merge"
#require "facets"

class Hash
    def sample(n)
      Hash[to_a.sample(n)]
    end
end


module Set_qualities
    def set_qualities(*args)
        @qualities = Qualities.all.map {|key,value| [key, value.select {|k,v|
            args.include? k}]}.to_h
            self.qualities.each_pair do |key, value|       
                instance_variable_set("@#{key}", value)
                self.class.instance_eval { attr_accessor key.to_sym, :name, :qualities, :animals} #:temperature }
            end       
    end
end

class World

    @@etype = [{name: 'River', qualities: [:s3, :s4, :s5, :s6, :m3, :m4, :m8, :m9, :m10, :m12, :c1, :c2, :c3, :c4, :c5, :c6, :c7,
        :c9, :c11, :c13, :c14, :t1, :t2, :t3, :t4, :t5, :t6, :d1, :d2, :d3, :d4, :d5, :loc2, :loc3]}, {name: 'Lake', 
        qualities: [:s3, :s4, :s5, :s6, :m3, :m4, :m8, :m9, :m10, :m12, :c1, :c3, :c4, :c5, :c6, :c9, :c11, 
        :c13, :c14, :t1, :t2, :t3, :t4, :t5, :t6, :d1, :d2, :d3, :d4, :d5, :loc2, :loc3]}, {name: 'Ocean', qualities: [:s1, :s2, :s3, :s4, :s5, :s6, :m3, 
        :m4, :m5, :m8, :m9, :m10, :m12, :c1, :c2, :c3, :c4, :c5, :c6, :c7, :c8, :c9, :c10, :c11, :c12, :c13, :c14, :t1, 
        :t2, :t3, :t4, :t5, :t6, :d1, :d2, :d3, :d4, :loc2, :loc3]}, {name: 'Tundra', qualities: [:s2, :s3, :s4, :s5, 
        :s6, :m1, :m2, :m3, :m4, :m7, :m9, :m10, :c1, :c3, :cd, :c13, :t2, :d1, :d2, :d3, :d5, :d6, :loc1, :loc2]},
        {name: 'Desert', qualities: [:s5, :s6, :m1, :m6, :m9, :c2, :c3, :c13, :c10, :t7, :d1, :d5, :d6, :loc1, :loc2]},
        {name: 'Arctic', qualities: [:s1, :s2, :s3, :s4, :m1, :m3, :m4, :m10, :m11, :c1, :c6, :c9, :t1, :d1, :d4, :loc1, 
        :loc2, :loc3]},{name: 'Savannah', qualities: [:s1, :s2, :s3, :s4, :s3, :s2, :s1, :m1, :m2, :m4, :m6, :m7, :m9, :m10, 
        :m11, :c3, :c2,:c4, :c6, :c7, :c12, :c13, :c10, :t5, :t6, :d1, :d2, :d3, :d5, :d6, :loc1, :loc2]}, {name: 'Coastal', qualities: [:s3, :s4, :s5, :s6, :m3, :m4, :m6, :m9, :m10, :m11, :m12, :s2, :c5, :c6, :c8, :c9, :c10, 
        :c11, :c12, :c13, :c14, :t1, :t2, :t3, :t4, :t5, :t6, :t7, :d1, :d2, :d3, :d4, :d5,:loc1, :loc2, :loc3]}, {name: 'Alpine', qualities: [:s3, :s4, :s5, :s6, :m1, :m2, :m4, :m7, :m9, :m10, :c1, :c6, :c7, :c9, :c13, :t1, :t2, :t3,
        :d1, :d2, :d3, :d5, :d6, :loc1, :loc2]},{name: 'Swamp', qualities: [:s2, :s3, :s4, :s5, :s6, :m2, :m3, :m4, :m5, :m6, :m8, :m9, :m10, :m11, :c2, :c3, :c4,
        :c7, :c8, :c9, :c10, :c12, :c13, :t3, :t4, :t5, :t6, :d1, :d2, :d3, :d4, :d5, :d6, :loc1, :loc2, :loc3]}, {name: 'Jungle', qualities: [:s2, :s3, :s4, :s5, :s6, :m1, :m2, :m4, :m5, :m6, :m9, :m10, :m11, :c3, :c4, :c7, :c8, :c9, 
        :c10, :c12, :c13, :t6, :t5, :d1, :d2, :d3, :d5, :d6, :loc1, :loc2]},{name: 'Forest', qualities: [:s2, :s3, :s4, :s5, :s6, :m1, :m2, :m4, :m6, :m7, :m9, :m10, :m11, :c3, :c4, :c6, :c9,
        :c12, :c7, :c13, :t2, :t3, :t4, :t5, :d1, :d2, :d3, :d5, :d6, :loc1, :loc2]},{name: 'Riparian', qualities: [:s2, :s3, :s4, :s5, :s6, :m2, :m3, :m4, :m6, :m7, :m9, :m10, :c2, :c3, :c4, :c6, :c8,
        :c9, :c11, :c5, :c13, :t2, :t3, :t4, :t5, :t6, :t7, :d1, :d2, :d3, :d4, :d5, :d6, :loc1, :loc2]}]

        #{name: 'Urban', qualities: [:s3, :s4, :s5, :s6, :s7, :m2, :m3, :m4, :m6, :m7, :m9, :m10, :c6, :c13, :t2, :t3, :t4, :t1, :t5, :t6,
        #:t7, :d1, :d2, :d3, :d4, :d5, :d6, :loc1, :loc2]},

    attr_accessor :start_time, :world_size, :current_time, :time, :world_temp, :world_environments#, :world_animals, :combined_world, :inclined_environment, :dominant_species
    def initialize(world_size:, world_environments: [], world_temp: {})
        @start_time = start_time || -3_000_000
        @current_time = current_time
        @world_temp = world_temp
        @world_size = world_size
        @world_environments = world_environments
        self.set_environments
        self.choose_temp
        self.describe_world
        self.world_temp
    end

    def add_environment(new_environment)
        world_environments << new_environment
        
    end

    def set_environments
        world_size.times do
            args =  @@etype.sample(1).reduce({}, :merge!); self.add_environment(Environment.new(**args))
        end
    end

    def choose_temp
        self.regional_temperatures.map {|k| k.replace(k.sample(1))}
    end

    def regional_temperatures
        self.world_environments.flatten.map {|x| x.qualities[:temperature]}
    end

    def world_temp
        test_temp = {}
        test_temp = self.world_environments.flatten.map {|x| test_temp = x.qualities[:temperature].to_h}.flatten
        world_temp = test_temp.flat_map(&:keys).each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }
        wt = world_temp.key(world_temp.values.max)
        world_temp = Quality.all.fetch(:temperature).select {|k,v| k == wt}
        puts "                                   ";sleep 2; $stdout.flush
        #puts "        Overall,";sleep 3; $stdout.flush 
        puts "this world is mostly a #{world_temp.values[0]} place"; sleep 3; $stdout.flush 
    end

    def describe_world
        #puts "   It is #{self.start_time.abs}; B.C."
        #puts "                                     "
        #sleep 4; $stdout.flush
        #puts Rainbow(" The world is composed of"); sleep 2; $stdout.flush
        #puts "                                     "
        wet1 = self.regional_temperatures.map {|x| x.values}.flatten
        wet2 = self.world_environments.flatten.map {|name| name.name}
        wet3 = wet1.zip(wet2).each {|x,y| x + y}.map {|x| x.join(" ")}
        wet = wet3.each_with_object(Hash.new(0)) {|word,counts| counts[word] += 1}.each do 
            |name, number| puts " #{number}   #{name} environments"; sleep 2; $stdout.flush
        end
    end

   

    def add_inital_animals
        #break all these down into methods that can be called on self. should then be able to be called within the methods

        #pick an animal from a list of all


        ra =  Animal.all.map {|x| [x.name => [x.preferred_temp, x.location, x.skin, x.colour, x.size, x.motion, x.mouth, x.temprement, x.diet].reduce({}, :merge!)]}
        sa = ra.flatten(1).sample(1).reduce({}, :merge!)
        p sa
        puts "_________________________"

        #check to see if the animal is compatible to the environment (temp and loc2)
        es = self.world_environments.map {|x| x.supports}
        p es
        st = self.world_environments.map {|x| x.qualities[:temperature]}
        p st 
        puts "_________________________"
        #If animal is compatible insert it into an environment


    

        #ip = self.world_environments.map {|x| x.animals == {} ? ra.flatten(1).sample(1).reduce({}, :merge!) :x}
        ip = self.world_environments.map {|x| x.animals}.map!{|x| x == {} ? sa : x}
        p ip
        p"_________________________________________"
        #p self.world_environments.map {|x| x.animals}.zip(ip).flatten(1).delete_if &:empty?
        #This method checks the content of all te world environments animal hash
        p self.world_environments.map {|x| x.animals}
        p"_________________________________________"
        #self.world_environments.map {|x| x.animals}.zip(iw).flatten(1).delete_if &:empty?
        #This prints all the world environments
        p self.world_environments
        
        #Animal.all.sample(1).map {|x| [x.name => [x.preferred_temp, x.location, x.skin, x.colour, x.size, x.motion, x.mouth, x.temprement, x.diet].reduce({}, :merge!)]}.flatten(1).reduce({}, :merge!) :x}
        




    

        #self.world_environments.map!{|x| x.animals.each {|x| x[Animal.all.Sample(1)]}}

        #p self.world_environments.map {|x| x.animals.merge!(animal1)}
        
            #then p Animal.all.sample(1).map {|x| [x.name => [x.preferred_temp, x.location].reduce({}, :merge!)]}.flatten(1)
         #end
        #p Animal.all.sample(1)

        puts "_________________________"
        #This method pulls up what each world environment supports and its temp
        location = self.world_environments.map{|x| [x.name => [x.temperature, x.supports, x.animals].reduce({}, :merge!)]}.flatten(1)
        p location
        puts "_________________________"
        #This method pulls up a random animal and all of it's qualities
        animal = Animal.all.sample(1).map {|x| [x.name => [x.preferred_temp, x.location, x.skin, x.colour, 
            x.size, x.motion, x.mouth, x.temprement, x.diet].reduce({}, :merge!)]}.flatten(1)     #pick an animal
        p animal.reduce({}, :merge!)

        #CHECK THE STATUS OF ANIMALS AND IF EMPTY ADD AN ANIMAL
        
        #while loop   While self.world_environments animals is empty perform add animal
        
        #p self.world_environments.map {|x| x.supports}
        

        puts "____________________________"
        #p self.world_environments.map {|x| x.animals}
        puts "____________________________"
        #p self.world_environments






    end

        #METHOD FOR ADDING ANIMALS

    def add_animal
        animal = Animal.all.sample(1).map {|x| [x.name => [x.preferred_temp, x.location, x.skin, x.colour, x.size, x.motion, x.mouth, x.temprement, x.diet].reduce({}, :merge!)]}.flatten(1)     #pick an animal
        p animal
        k1 = inhabited_we.map {|x| x.supports.map {|x| x.keys}.flatten(2)
        p k1
        k2 = animal.map {|k| k.map {|k,v| v.keys}}.flatten(2)  
        p k2     #check to see if the environment supports this kind of animal
        while (k1 & k2).empty?  
            animal = Animal.all.sample(1).map {|x| [x.name => [x.preferred_temp, x.location, x.skin, x.colour, x.size, x.motion, x.mouth, x.temprement, x.diet].reduce({}, :merge!)]}.flatten(1) 
        end 
        p animal       
        self.world_environments.map {|x| x.animals}.merge!(animal)}
    end

        #This is part of the code to add animals
        #inhabited_we = self.world_environments
        #inhabited_we.map {|x| x.animals}.each do |x| 
            #if x == {}                                      #an empty array   maybe use empty? and check for truth
                



        #p self.world_environments.sample(1)
        

        #p self.world_environments.sample(1)
    

        #people2_by_name = Hash[people2.map { |h| [h[:name], h] }]
        #people1.select { |h| people2_by_name.has_key?(h[:name]) }
       #      .map { |h| [h, people2_by_name[h[:name]]] }
    

       #results = Hash.new { |h, k| h[k] = {b: 0, c: 0} }
       #array_of_hashes.each do |h|
         #cummulative_hash = results[h[:description]]
         #cummulative_hash[:b] += h[:b]
         #cummulative_hash[:c] += h[:c]

    
end

class Environment
    include Set_qualities
    @environments = []
    self.class.public_send(:attr_reader, :environments)
    attr_accessor :name, :qualities, :animals
    def initialize(name: '', qualities: [], animals: {}) 
        @name = name
        @qualities = qualities
        self.set_qualities(*qualities) 
        self.class.environments << self
        @animals = animals
    end

    def self.all
        ObjectSpace.each_object(Environment).map {|name| name}
    end

    #def self.animals
        #animals << animal1 + animal2
    #end



end






class Urban 
    #include Set_qualities
    attr_accessor :name, :qualities
    def initialize(name: '', qualities: [])
        @name = name
        @qualities = qualities
        self.set_qualities(*qualities)
    end
end

class Qualities 
    attr_accessor :qualities
    def initialize(qualities: {})
        @qualities = qualities.map {|types| types.types.to_h}.reduce({}, :merge!)
        self.qualities.each_pair do |key, value|       
            instance_variable_set("@#{key}", value)
            self.class.instance_eval { attr_accessor key.to_sym }
        end
    end

    def self.all
        ObjectSpace.each_object(self).map {|qualities| qualities.qualities.to_h}.reduce({}, :merge!) 
    end
end


class Quality
    attr_accessor :name, :types
    def initialize(name:, types: {})
        @name = name
        @types = OpenStruct.new(types)
    end

    def self.all
        ObjectSpace.each_object(self).map {|types| types.types.to_h}.reduce({}, :merge!) 
    end

    def hash_of_types
        instance_variables.map do |var| 
          [var[1..-1].to_sym, instance_variable_get(var)]
        end.to_h
    end
end

class Hash
    def without(*keys)
      cpy = self.dup
      keys.each { |key| cpy.delete(key) }
      cpy
    end
end



class Animal
    
    # This is the method engine that assembles animals and assigns instance variables and methods

    def set_traits(*traits)
        traits.flatten!
        @traits = Traits.all.map {|key,value| [key, value.select {|k,v| 
            traits.include? k}]}.to_h 
            self.traits.each_pair do |key, value|       
                instance_variable_set("@#{key}", value)
                self.class.instance_eval { attr_accessor key.to_sym, :name, :traits }
            end           
    end

    def self.all
        ObjectSpace.each_object(self).map {|name, qualities| name}
    end

    # This is the method engine that links an animal with an environment

    #def animals_preffered
        #@animals_preffered =
        #check each animal preferred_temp against temperature   
        #set instance variable 
    #end

    
end

#These subclasses could be replaced by passing location and lives on through to Traits.new along with skin etc.
#and then just specifying the keys in the args along with skin etc.  This was just an inheritance exercise.  

class Land_Animal < Animal
    attr_accessor :name, :location, :lives_on, :extra_traits, :traits
    def initialize(name: '', extra_traits: {}, location: {}, lives_on: {}, traits: []) 
        @name = name
        @lives_on = {lives_on: {lo1: 'Land'}}
        @location = {location: {loc1: 'Land Animal'}}
        @extra_traits = extra_traits.merge!(self.location).merge!(self.lives_on)
        @traits = *traits.concat(extra_traits.map {|k,v| v.keys}).flatten
        self.set_traits(*traits) 
    end

    

end

class Water_Animal < Animal
    attr_accessor :name, :location, :lives_on, :extra_traits, :traits
    def initialize(name: '', extra_traits: {}, location: {}, lives_on: {}, traits: []) 
        @name = name
        @lives_on = {lives_on: {lo3: 'Water'}}
        @location = {location: {loc3: 'Water Animal'}}
        @extra_traits = extra_traits.merge!(self.location).merge!(self.lives_on)
        @traits = *traits.concat(extra_traits.map {|k,v| v.keys}).flatten
        self.set_traits(*traits)
    end

    

end

class Areal_Animal < Animal
    attr_accessor :name, :location, :lives_on, :extra_traits, :traits
    def initialize(name: '', extra_traits: {}, location: {}, lives_on: {}, traits: []) 
        @name = name
        @location = {location:{loc2: 'Areal Animal'}}
        @lives_on = {lives_on: {lo2: 'Air'}}
        @extra_traits = extra_traits.merge!(self.location).merge!(self.lives_on)
        @traits = *traits.concat(extra_traits.map {|k,v| v.keys}).flatten
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

    def self.all
      ObjectSpace.each_object(self).to_a.map {|types| types.types.to_h}.reduce({}, :merge!)
    end

    def hash_of_types
      instance_variables.map do |var| 
        [var[1..-1].to_sym, instance_variable_get(var)]
      end.to_h
    end

end


#Dynamic list of Quality types. Partly coresponds to Animal Trait

encourages_size = Quality.new(name: 'encourages size', types: {encourages_size: {s1: "Enormous", s2: "Large", s3: "Average", 
    s4: "Small", s5: "Little", s6: "Tiny"}})
encourages_mouth = Quality.new(name: 'encourages mouth', types: {encourages_mouth: {m1: "fanged", m2: "lipped", m3: "billed", 
    m4: "multi-toothed", m5: "razor-toothed", m6: "longue-tongued", m7: "flat toothed", m8: "fish mouthed", m9: "pincered", 
    m10: "beaked", m11: "tusked", m12: "mouthless"}}) 
camoflage = Quality.new(name: 'camoflage colour', types: {camoflage: {c1: "white", c2: "yellow", c3: "brown", c4: "green",
    c5: "blue_grey", c6: "grey", c7: "spotted", c8: "technicolour", c9: "black", c10: "red", c11: "blue", c12: "striped", 
    c13: 'patchy', c14: 'translucent'}})    
contrast = Quality.new(name: 'contrast colour', types: {contrast: {c1: "white", c2: "yellow", c3: "brown", c4: "green",
    c5: "blue_grey", c6: "grey", c7: "spotted", c8: "technicolour", c9: "black", c10: "red", c11: "blue", c12: "striped", 
    c13: 'patchy', c14: 'translucent'}})
temperature = Quality.new(name: 'temperature', types: {temperature: {t1: "frozen", t2: "cold", t3: "temperate",
     t4: "mediterranean", t5: "warm", t6: "hot", t7: "scorching"}})
food_resources = Quality.new(name: 'food resources', types: {food_resources: {d1: 'meat', d2: 'varied', d3: 'vegetable', d4: 'fish', 
    d5: 'insects', d6: 'sugar'}})

supports = Quality.new(name: 'supports', types: {supports: {loc1: "Land Animal", loc2: "Areal animal", loc3: "Water animal"}}) 

environment_qualities = Qualities.new(qualities: [encourages_size, encourages_mouth, camoflage, contrast, temperature,
     food_resources, supports])


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
     sk5: "feathered", sk6: "hard shelled", sk7: "blubbery", sk8: "skinless", sk9: "spikey"}})
colour = Trait.new(name: 'colour', types: {colour: {c1: "white", c2: "yellow", c3: "brown", c4: "green",
     c5: "blue_grey", c6: "grey", c7: "spotted", c8: "technicolour", c9: "black", c10: "red", c11: "blue", c12: "striped", 
     c13: 'patchy', c14: 'translucent'}})    
preferred_temp = Trait.new(name: 'preferred temperature', types: {preferred_temp: {t1: "frozen", t2: "cold", 
    t3: "temperate", t4: "mediterranean", t5: "warm", t6: "hot", t7: "scorching"}})
diet = Trait.new(name: "diet", types: {diet: {d1: 'meat eating', d2: 'omnivorous', d3: 'vegetarian', d4: 'fish eating', 
    d5: 'insect eating', d6: 'sugar eating'}})
temprement =Trait.new(name: 'temprement', types: {temprement: {tem1: 'hostile', tem2: 'agressive', tem3: 'passive', tem4: 'docile', tem5: 'bad natured'}})


#extra traits

location = Trait.new(name: 'location', types: {location: {loc1: "Land Animal", loc2: "Areal animal", loc3: "Water animal"}})
lives_on = Trait.new(name: 'lives on', types: {lives_on: {lo1: "land", lo2: "air", lo3: "water"}})

    
#send above Trait list to Traits (could also send location and lives_on here)

animal_traits = Traits.new(traits: [skin, mouth, colour, size, preferred_temp, speed, motion, diet, temprement,location, lives_on])

  
#Areal Animal list
    
finch = Areal_Animal.new(name: "Finch", traits:[:s5, :sp8, :mo9, :m10, :sk5, :c2, :t3, :d3, :tem4])
vulture = Areal_Animal.new(name: "Vulture", traits: [:s3, :sp7, :mo9, :m10, :sk5, :c6, :t5, :d1, :tem3]) 
albatross = Areal_Animal.new(name: "Albatross", traits: [:s3, :sp7, :mo9, :m10, :sk5, :c1, :t3, :d4, :tem3])
bat = Areal_Animal.new(name: "Bat", traits: [:s5, :sp8, :mo9, :m4, :sk3, :c9, :t4, :d5, :tem3])
dragonfly = Areal_Animal.new(name: "Dragonfly", traits: [:s6, :sp6, :mo10, :m9, :sk6, :c14, :t5, :d5, :tem2])
puffin = Areal_Animal.new(name: "Puffin", traits: [:s4, :sp7, :mo9, :m10, :sk5, :c8, :t2, :d4, :tem4])
falcon= Areal_Animal.new(name: "Falcon", traits: [:s4, :sp6, :mo9, :m10, :sk5, :c3, :t3, :d1, :tem2])
moth= Areal_Animal.new(name: "Moth", traits: [:s6, :sp8, :mo10, :m9, :sk1, :c9, :t5, :d6, :tem4])
butterfly = Areal_Animal.new(name: "Butterfly", traits: [:s6, :sp8, :mo10, :m9, :sk1, :c8, :t5, :d6, :tem4]) 
condor = Areal_Animal.new(name: "Condor", traits: [:s3, :sp7, :mo9, :m10, :sk5, :c9, :t4, :d1, :tem3])
pidgeon = Areal_Animal.new(name: "Pidgeon", traits: [:s5, :sp8, :mo9, :m10, :sk5, :c6, :t3, :d3, :tem4])
wasp = Areal_Animal.new(name: "wasp", traits: [:s6, :sp6, :mo10, :m9, :sk6, :c12, :t3, :d5, :tem1])
    
#Water Animal list

walrus = Water_Animal.new(name: 'Walrus', traits: [:s2, :sp1, :mo6, :m11, :sk7, :c6, :t1, :d4, :tem5]) 
whale = Water_Animal.new(name: 'Whale', traits: [:s1, :sp7, :mo7, :m4, :sk3, :c5, :t2, :d4, :tem3])
shark = Water_Animal.new(name: 'Shark', traits: [:s2, :sp7, :mo7, :m5, :sk3, :c5, :t4, :d1, :tem2])
jellyfish = Water_Animal.new(name: 'Jellyfish', traits: [:s4, :sp1, :mo11, :m12, :sk7, :c14, :t4, :d4, :tem4])
urchin = Water_Animal.new(name: 'Urchin', traits: [:s5, :sp2, :mo14, :m10, :sk6, :c10, :t2, :d4, :tem4])
sealion = Water_Animal.new(name: 'Sealion', traits: [:s2, :sp7, :mo6, :m4, :sk7, :c6, :t2, :d4, :tem3])
cod = Water_Animal.new(name: 'Cod', traits: [:s4, :sp5, :mo7, :m8, :sk4, :c3, :t2, :d4, :tem4])
eel = Water_Animal.new(name: 'Eel', traits: [:s4, :sp7, :mo8, :m5, :sk3, :c9, :t4, :d4, :tem2])
flounder = Water_Animal.new(name: "Flounder", traits: [:s4, :sp8, :mo7, :m8, :c7, :t2, :d4, :tem4])
prawn= Water_Animal.new(name: "Prawn", traits: [:s6, :sp4, :mo13, :m9, :sk6, :c8, :t3, :d3, :tem4])
grouper = Water_Animal.new(name: "Grouper", traits: [:s2, :sp7, :mo7, :m8, :sk4, :c6, :t3, :d4, :tem3])

#Land Animal list

snake = Land_Animal.new(name: 'Snake', traits: [:s4, :sp5, :mo8, :m6, :sk4, :c4, :t6, :d1, :tem2])
pangolin = Land_Animal.new(name: 'Pangolin',traits: [:s4, :sp4, :mo3, :m6, :sk4, :c10, :t5, :d5, :tem3])
aligator = Land_Animal.new(name: 'Aligator',traits: [:s2, :sp1, :mo3, :m4, :sk4, :c4, :t6, :d1, :tem2])
scorpion = Land_Animal.new(name: 'Scorpion',traits:  [:s5, :sp2, :mo13, :m9, :sk6, :c2, :t7, :d5, :tem3])
bushbaby = Land_Animal.new(name: 'Bushbaby',traits: [:s4, :sp2, :mo2, :m2, :sk2, :c3, :t5, :d3, :tem4])
ocelot = Land_Animal.new(name: "Ocelot", traits: [:s4, :sp5, :mo3, :m4, :sk2, :c12, :t5, :d1, :tem3])
mongoose = Land_Animal.new(name: 'Mongoose',traits: [:s4, :sp4, :mo1, :m4, :sk2, :c3, :t5, :d1, :tem2])
lynx = Land_Animal.new(name: 'Lynx',traits: [:s3, :sp6, :mo3, :m1, :sk1, :c3, :t2, :d1, :tem2])
antelope = Land_Animal.new(name: 'Antelope',traits: [:s3, :sp6, :mo5, :m2, :sk2, :c3, :t5, :d3, :tem4])
bear = Land_Animal.new(name: "Bear", traits: [:sk1, :m1, :c3, :s2, :t2, :sp3, :mo3, :d2, :tem3])
jackal = Land_Animal.new(name: 'Jackal', traits: [:sk2, :m1, :c3, :s3, :t5, :sp5, :mo3, :d1, :tem2])
donkey = Land_Animal.new(name: 'Donkey', traits: [:sk2, :m2, :c6, :s2, :t4, :sp3, :mo5, :d3, :tem5])
groundhog = Land_Animal.new(name: 'Groundhog', traits: [:sk2, :m2, :c6, :s4, :t3, :sp4, :mo3, :d3, :tem3 ])
tortoise = Land_Animal.new(name: 'Tortoise', traits: [:sk6, :m10, :c5, :s4, :sp1, :t6, :mo3, :d3, :tem4])
salamander = Land_Animal.new(name: 'Salamander', traits:[:s6, :sp9, :mo4, :m6, :sk4, :c4, :t6, :d5, :tem3])
caribou = Land_Animal.new(name: 'Caribou', traits: [:s3, :sp3, :mo5, :m2, :sk2, :c3, :t2, :d3, :tem4])
jaguar = Land_Animal.new(name: 'Jaguar', traits: [:s3, :sp5, :mo3, :m1, :sk2, :c7, :t6, :d1, :tem2])
centipede = Land_Animal.new(name: 'Centipede',traits: [:s6, :sp4, :mo13, :m9, :sk6, :c10, :t6, :d5, :tem2])
spider = Land_Animal.new(name: 'Spider', traits: [:s6, :sp9, :mo13, :m9, :sk6, :c9, :t6, :d5, :tem2])
gecko = Land_Animal.new(name: 'Gecko', traits: [:s5, :sp4, :mo4, :m6, :sk4, :c4, :t6, :d5, :tem2])
toad = Land_Animal.new(name: 'Toad', traits: [:s4, :sp1, :mo2, :m6, :sk3, :c4, :t4, :d5, :tem3])
aardvark = Land_Animal.new(name: 'Aardvark',traits: [:s3, :sp4, :mo3, :m6, :sk2, :c3, :t5, :d5, :tem3])
beetle = Land_Animal.new(name: 'Beetle', traits: [:s6, :sp4, :mo13, :m9, :sk6, :c9, :t3, :d3, :tem4])
mole = Land_Animal.new(name: 'Mole', traits: [:s5, :sp4, :mo3, :m4, :sk2, :c6, :t3, :d5, :tem3])
racoon = Land_Animal.new(name: "Racoon", traits: [:s4, :sp3, :mo3, :m4, :sk1, :c13, :t3, :d2, :tem3])
boar = Land_Animal.new(name: 'Boar', traits: [:s3, :sp6, :mo1, :m11, :sk2, :c3, :t5, :d2, :tem1])
porcupine = Land_Animal.new(name: "Porcupine", traits:[:s4, :sp1, :mo3, :m2, :sk9, :c3, :t2, :d3, :tem4])





new_world = World.new(world_size: 4)
new_world.add_inital_animals