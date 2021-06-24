class Animal
    attr_accessor :traits
    def initialize(traits: {})
        @traits = traits
    end
end

class Traits
    attr_accessor :traits
    def initialize(traits: {name: '',skin: '', motion: ''})
        @traits = traits
        @name = name
        @skin = skin
        @motion = motion
    end
end

class Trait
    attr_accessor :name
    def initialize(name: '')
        @name = name
    end

    def types(options = {}) #first create a method that spits out a hash of keys and values
        name.types
    end

    def make_instances  #Create a method that takes the keys from the hash an creates getters/setters for them and instance variables/initialize the keywords
    end








       

skin = Trait.new(sk1: "furry", sk2: "short haired", sk3: "leathery", sk4: "scaled", sk5: "feathered", sk6: "hard shelled", sk7: "blubbery", sk8: "skinless")
motion = Trait.new(mo1: "pad footed", mo2: "spring footed", mo3: 'clawed', mo4: 'web footed', mo5: 'hoofed', mo6: 'flippered', mo7: 'finned', mo8: 'serpentine', mo9: 'single winged', mo10: 'multi winged', mo11: 'drifting', mo12: "tentacled")

p skin