
require "pry"
require "ostruct"

class Animal
    attr_accessor :name, :traits
    def initialize(name: '', traits: {})
        @name = name
        @traits = traits #Traits.all.keys #need to add methods here maybe with forwardable or maybe as in Traits
    end


    def get_traits(*args)
        @traits = Traits.all.map {|key,value| [key, value.select {|k,v| 
            args.include? k}]}.flatten#.reduce({}, :merge!)  #need to get the symbol (i.e skin:, motion:) back in? otherwise cant call methods
        #@traits = Traits.all.select {|k,v| args.include? k}
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
        #ObjectSpace.each_object(self).to_a.map {|traits| traits.traits.to_h}.reduce({}, :merge!) 
        ObjectSpace.each_object(self).map {|traits| traits.traits.to_a}.flatten(1)#.reduce({}, :merge!) 
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



skin = Trait.new(name: 'skin', types: {skin: {sk1: "furry", sk2: "short haired", sk3: "leathery", sk4: "scaled", sk5: "feathered", sk6: "hard shelled",
     sk7: "blubbery", sk8: "skinless"}})
mouth = Trait.new(name: 'mouth' , types: {mouth: {m1: "fanged", m2: "lipped", m3: "billed", m4: "multi-toothed", m5: "razor-toothed", 
    m6: "longue-tongued", m7: "omnivorous", m8: "fish mouthed", m9: "pincered", m10: "beaked", m11: "tusked", m12: "mouthless"}})
colour = Trait.new(name: 'colour', types: {colour: {c1: "white", c2: "yellow", c3: "brown", c4: "green", c5: "blue_grey", c6: "grey", c7: "spotted",
     c8: "technicolour", c9: "black", c10: "red", c11: "blue"}})
size = Trait.new(name: 'size', types: {size: {s1: "Enormous", s2: "Large", s3: "Average", s4: "Small", s5: "Tiny", s6: "Little"}})
preferred_temp = Trait.new(name: 'preferred_temp', types: {preferred_temp: {t1: "frozen", t2: "cold", t3: "temperate", t4: "mediterranean", t5: "warm", t6: "hot",
     t7: "scorching"}})
speed = Trait.new(name: 'speed', types: {speed: {sp1: "lethargic", sp2: "slow", sp3: "sauntering", sp4: "quick", sp5: "fast", sp6: "gliding", sp7: "fluttering",
     sp8: "darting"}})
motion = Trait.new(name: 'motion', types: {motion: {mo1: "pad footed", mo2: "spring footed", mo3: 'clawed', mo4: 'web footed', mo5: 'hoofed', mo6: 'flippered',
     mo7: 'finned', mo8: 'serpentine', mo9: 'single winged', mo10: 'multi winged', mo11: 'drifting', mo12: "tentacled"}})
    




animal_traits = Traits.new(traits: [skin, mouth, colour, size, preferred_temp, speed, motion])






bear = Animal.new(name: "Bear", traits: {})
#bear.get_traits(:skin)
bear.get_traits(:sk1, :m1, :c1,:s1, :t1, :sp1, :mo1)
#bear = Animal.new(name: name[:n1], motion: motion[:m1], skin: skin[:sk1], mouth: mouth[:m7], colour: colour[:c3], size: size[:s3], preferred_temp: preferred_temp[:t3], speed: speed[:sp3])



#p flatten_hash_from(animal_traits.traits)
#p animal_traits.traits[:skin]
#p animal_traits.traits.map {|types| types.types.to_h}  #This creates an array of type hashes
#p Traits.traits[0][:sk1] #This pulls the specific value in an index of the traits array of hashes
#p skin.types.skin[:sk1]
#p animal_traits.traits[0].types.sk4
#p animal_traits.traits[0].get_types
#p Trait.all#.map {|keys,value| keys.keys.to_h}
#p skin.get_types
#p animal_traits.traits.traits_to_hash
#p animal_traits.traits
#p bear_traits
#p animal_traits.traits[:skin][:sk2]
#p skin.types
p bear.traits
#p Traits.all
#p motion.types



#p Traits.all&.dig(:skin,:sk1)  #This will return the value in a nested hash


#*args = (:skin)
#p Traits.all&.dig(*args)