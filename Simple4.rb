
require "pry"
require "ostruct"

class Animal
    attr_accessor :name, :traits
    def initialize(name:, traits: {})
        @name = name
        @traits = traits
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
        ObjectSpace.each_object(self).to_a
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
      ObjectSpace.each_object(self).to_a
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

animal_traits = Traits.new(traits: [skin, mouth])

module TraitsFactory
    def self.build(type, trait_class, traits_class)
        traits_class.new(
            type.collect {|types| 
            trait_class.new(
                :skin, :mouth)})
    end
end

bear_traits = TraitsFactory.build(bear_type)
bear_type = {motion: motion[:m1], skin: skin[:sk1]}

#p flatten_hash_from(traits.traits)
#p traits.traits[:skin]
#p traits.traits.map {|types| types.types.to_h}  #This creates an array of type hashes
#p traits.traits[0][:sk1] #This pulls the specific value in an index of the traits array of hashes

#p traits.traits[0].types.sk4
#p traits.traits[0].get_types
#p Trait.all
p Traits.all
#p skin.get_types
#p traits.traits.traits_to_hash
p animal_traits.traits
#p animal_traits.traits[:skin][:sk2]