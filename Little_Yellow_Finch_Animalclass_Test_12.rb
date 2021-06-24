class Animal  
    attr_accessor :name, :type, :lives_on, :traits
    def initialize(traits: {})
        @traits = traits
    end
    def traits
        traits.merge(extra_traits) || default_traits
    end
    def default_traits
        raise NotImplementedError  
            "This #{self.class} cannot respond to:"
    end

    def traits(name)
        puts name.traits 
    end
end


class Land_Animal < Animal
    attr_accessor :name, :type, :lives_on
    def initialize(name:, traits:, extra_traits: {})
        @name = name
        @type = extra_traits.fetch[:type, 'Land Animal']
        @lives_on = extra_traits.fetch[:lives_on, 'Land']
        super(traits: traits) || default_traits    
    end
    def default_traits
        traits = {motion: motion[:m2], skin: skin[:sk2], mouth: mouth[:m2], colour: colour[:c3], size: size[:s3], temp: temp[:t3], speed: speed[:sp3]}
    end
    def type_traits
        {name: name, extra_traits: extra_traits}
    end
end

class Water_Animal < Animal
    attr_accessor :name, :type, :lives_on
    def initialize(name:, extra_traits: {})
        @name = name
        @type = extra_traits.fetch[:type, 'Water Animal']
        @lives_on = extra_traits.fetch[:lives_on, 'Water']
        super(traits: traits) || default_traits
    end
    def default_traits
        traits = {motion: motion[:mo7], skin: skin[:sk4], mouth: mouth[:m8], colour: colour[:c3], size: size[:s4], preferred_temp: preferred_temp[:t2], speed: speed[:sp4]}
    end
    def type_traits
        {name: name, extra_traits: extra_traits}
    end
end

class Areal_Animal < Animal
    attr_accessor :name, :type, :lives_on
    def initialize(name:, extra_traits: {})
        @name = name
        @type = extra_traits.fetch[:type, "Areal Animal"]
        @lives_on = extra_traits.fetch[:lives_on, "Air"]
        super(traits: traits) || default_traits
    end

    def default_traits
        traits = {motion: motion[:mo9], skin: skin[:sk5], mouth: mouth[:m10], colour: colour[:c2], size: size[:s6], preferred_temp: preferred_temp[:t5], speed: speed[:sp4]}
    end
    def type_traits
        {name: name, extra_traits: extra_traits}
    end
end

class Traits
    attr_accessor :traits, :name, :skin, :mouth, :colour, :size, :preferred_temp, :motion
    def initialize(traits: {})
        @traits = :traits.merge(traits)  #types?  not sure how to create this hash of types

        @name = traits[:name]  
        @skin = traits[:skin]
        @mouth = traits[:mouth]
        @colour = traits[:colour]
        @size = traits[:size]
        @preferred_temp = traits[:preferred_temp]
        @motion = traits[:motion]

    end
    def traits
        :traits.merge(trait)
    end
end


class Trait < Traits                           
    attr_accessor :types         
    def initialize(types: {})    
        @types = types
        
    end
    def trait
        types
    end
                                        #@needs_trait = type{}.each .fetch(needs_trait:, true)
end

class AnimalFactory
    TYPES = {
      employee: Employee,
      boss: Boss
    }
  
    def self.for(type, attributes)
      (TYPES[type] || Person).new(attributes)
    end
  end
  
  employee = PersonFactory.for(:employee, name: 'Danny')
  boss = PersonFactory.for(:boss, name: 'Danny')
  person = PersonFactory.for(:foo, name: 'Danny')


#Traits list
skin = Trait.new(sk1: "furry", sk2: "short haired", sk3: "leathery", sk4: "scaled", sk5: "feathered", sk6: "hard shelled", sk7: "blubbery", sk8: "skinless")
mouth = Trait.new(m1: "fanged", m2: "lipped", m3: "billed", m4: "multi-toothed", m5: "razor-toothed", m6: "longue-tongued", m7: "omnivorous", m8: "fish mouthed", m9: "pincered", m10: "beaked", m11: "tusked", m12: "mouthless")
colour = Trait.new(c1: "white", c2: "yellow", c3: "brown", c4: "green", c5: "blue_grey", c6: "grey", c7: "spotted", c8: "technicolour", c9: "black", c10: "red", c11: "blue")
size = Trait.new(s1: "Enormous", s2: "Large", s3: "Average", s4: "Small", s5: "Tiny", s6: "Little")
preferred_temp = Trait.new(t1: "frozen", t2: "cold", t3: "temperate", t4: "mediterranean", t5: "warm", t6: "hot", t7: "scorching")
speed = Trait.new(sp1: "lethargic", sp2: "slow", sp3: "sauntering", sp4: "quick", sp5: "fast", sp6: "gliding", sp7: "fluttering", sp8: "darting")
motion = Trait.new(mo1: "pad footed", mo2: "spring footed", mo3: 'clawed', mo4: 'web footed', mo5: 'hoofed', mo6: 'flippered', mo7: 'finned', mo8: 'serpentine', mo9: 'single winged', mo10: 'multi winged', mo11: 'drifting', mo12: "tentacled")

#Land Animal List

bear = Land_Animal.new(name: 'Bear', traits:{motion: motion[:mo1], skin: skin[:sk1], mouth: mouth[:m7], colour: colour[:c3], size: size[:s3], preferred_temp: preferred_temp[:t3], speed: speed[:sp3]})
jackal = Land_Animal.new(name: 'Jackal', traits: {motion: motion[:mo1], skin: skin[:sk2], mouth: mouth[:m1], colour: colour[:c3], size: size[:s3], preferred_temp: preferred_temp[:t5], speed: speed[:sp4]})
donkey = Land_Animal.new(name: 'Donkey', traits: {motion: motion[:mo2], skin: skin[:sk2], mouth: mouth[:m2], colour: colour[:c3], size: size[:s3], preferred_temp: preferred_temp[:t3], speed: speed[:sp3]})
groundhog = Land_Animal.new(name: 'Groundhog', traits: {motion: motion[:mo1], skin: skin[:sk2], mouth: mouth[:m2], colour: colour[:c3], size: size[:s4], preferred_temp: preferred_temp[:t3], speed: speed[:sp2]})
tortoise = Land_Animal.new(name: 'Tortoise', traits: {motion: motion[:mo1], skin: skin[:sk6], mouth: mouth[:m10], colour: colour[:c6], size: size[:s4], preferred_temp: preferred_temp[:t5], speed: speed[:sp1]})
salamander = Land_Animal.new(name: 'Salamander', traits: {motion: motion[:mo3], skin: skin[:sk3], mouth: mouth[:m6], colour: colour[:c4], size: size[:s4], preferred_temp: preferred_temp[:t5], speed: speed[:sp4]})
caribou = Land_Animal.new(name: 'Caribou', traits: {motion: motion[:mo2], skin: skin[:sk2], mouth: mouth[:m2], colour: colour[:c3], size: size[:s2], preferred_temp: preferred_temp[:t2], speed: speed[:sp3]})
jaguar = Land_Animal.new(name: 'Jaguar', traits: {motion: motion[:mo1], skin: skin[:sk2], mouth: mouth[:m1], colour: colour[:c7], size: size[:s3], preferred_temp: preferred_temp[:t6], speed: speed[:sp5]})
centipede = Land_Animal.new(name: 'Centipede',traits: {motion: motion[:mo5], skin: skin[:sk6], mouth: mouth[:m9], colour: colour[:c10], size: size[:s5], preferred_temp: preferred_temp[:t6], speed: speed[:sp3]})
spider = Land_Animal.new(name: 'Spider', traits: {motion: motion[:mo5], skin: skin[:sk1], mouth: mouth[:m9], colour: colour[:c3], size: size[:s5], preferred_temp: preferred_temp[:t4], speed: speed[:sp4]})
gecko = Land_Animal.new(name: 'Gecko', traits: {motion: motion[:mo3], skin: skin[:sk3], mouth: mouth[:m6], colour: colour[:c4], size: size[:s5], preferred_temp: preferred_temp[:t6], speed: speed[:sp4]})
toad = Land_Animal.new(name: 'Toad', traits: {motion: motion[:mo3], skin: skin[:sk3], mouth: mouth[:m6], colour: colour[:c4], size: size[:s5], preferred_temp: preferred_temp[:t5], speed: speed[:sp1]})
aardvark = Land_Animal.new(name: 'Aardvark',traits: {motion: motion[:mo6], skin: skin[:sk2], mouth: mouth[:m2], colour: colour[:c3], size: size[:s4], preferred_temp: preferred_temp[:t3], speed: speed[:sp5]})
beetle = Land_Animal.new(name: 'Beetle', traits: {motion: motion[:mo5], skin: skin[:sk6], mouth: mouth[:m9], colour: colour[:c9], size: size[:s5], preferred_temp: preferred_temp[:t5], speed: speed[:sp2]})
mole = Land_Animal.new(name: 'Mole', traits: {motion: motion[:mo1], skin: skin[:sk2], mouth: mouth[:m2], colour: colour[:c3], size: size[:s5], preferred_temp: preferred_temp[:t3], speed: speed[:sp4]})
snake = Land_Animal.new(name: 'Snake', traits: {motion: motion[:mo4], skin: skin[:sk4], mouth: mouth[:m6], colour: colour[:c4], size: size[:s4], preferred_temp: preferred_temp[:t6], speed: speed[:sp4]})
pangolin = Land_Animal.new(name: 'Pangolin',traits: {motion: motion[:mo1], skin: skin[:sk6], mouth: mouth[:m2], colour: colour[:c4], size: size[:s4], preferred_temp: preferred_temp[:t5], speed: speed[:sp3]})
aligator = Land_Animal.new(name: 'Aligator',traits: {motion: motion[:mo1], skin: skin[:sk4], mouth: mouth[:m1], colour: colour[:c4], size: size[:s2], preferred_temp: preferred_temp[:t6], speed: speed[:sp1]})
scorpion = Land_Animal.new(name: 'Scorpion',traits:  {motion: motion[:mo5], skin: skin[:sk6], mouth: mouth[:m9], colour: colour[:c2], size: size[:s5], preferred_temp: preferred_temp[:t6], speed: speed[:sp4]})
bushbaby = Land_Animal.new(name: 'Bushbaby',traits:  {motion: motion[:mo1], skin: skin[:sk2], mouth: mouth[:m2], colour: colour[:c3], size: size[:s4], preferred_temp: preferred_temp[:t5], speed: speed[:sp2]})
ocelot = Land_Animal.new(name: "Ocelot", traits: {motion: motion[:mo1], skin: skin[:sk2], mouth: mouth[:m1], colour: colour[:c7], size: size[:s4], preferred_temp: preferred_temp[:t5], speed: speed[:sp5]})
mongoose = Land_Animal.new(name: 'Mongoose',traits: {motion: motion[:mo1], skin: skin[:sk2], mouth: mouth[:m1], colour: colour[:c3], size: size[:s4], preferred_temp: preferred_temp[:t5], speed: speed[:sp8]})
lynx = Land_Animal.new(name: 'Lynx',traits: {motion: motion[:mo1], skin: skin[:sk2], mouth: mouth[:m1], colour: colour[:c3], size: size[:s4], preferred_temp: preferred_temp[:t2], speed: speed[:sp5]})
antelope = Land_Animal.new(name: 'Antelope',traits: {motion: motion[:mo2], skin: skin[:sk2], mouth: mouth[:m2], colour: colour[:c2], size: size[:s3], preferred_temp: preferred_temp[:t3], speed: speed[:sp5]})
    

#Water Animal List

walrus = Water_Animal.new(name: 'Walrus', traits: {motion: motion[:mo6], skin: skin[:sk7], mouth: mouth[:m11], colour: colour[:c6], size: size[:s2], preferred_temp: preferred_temp[:t1], speed: speed[:sp1]})
whale = Water_Animal.new(name: 'Whale', traits: {motion: motion[:mo7], skin: skin[:sk3], mouth: mouth[:m2], colour: colour[:c5], size: size[:s1], preferred_temp: preferred_temp[:t3], speed: speed[:sp2]})
shark = Water_Animal.new(name: 'Shark', traits: {motion: motion[:mo7], skin: skin[:sk4], mouth: mouth[:m5], colour: colour[:c6], size: size[:s2], preferred_temp: preferred_temp[:t4], speed: speed[:sp4]})
jellyfish = Water_Animal.new(name: 'Jellyfish', traits: {motion: motion[:mo12], skin: skin[:sk8], mouth: mouth[:m12], colour: colour[:c11], size: size[:s4], preferred_temp: preferred_temp[:t5], speed: speed[:sp1]})
urchin = Water_Animal.new(name: 'Urchin', traits: {motion: motion[:mo6], skin: skin[:sk6], mouth: mouth[:m10], colour: colour[:c10], size: size[:s5], preferred_temp: preferred_temp[:t2], speed: speed[:sp1]})
sealion = Water_Animal.new(name: 'Sealion', traits: {motion: motion[:mo6], skin: skin[:sk2], mouth: mouth[:m4], colour: colour[:c6], size: size[:s2], preferred_temp: preferred_temp[:t2], speed: speed[:sp4]})
cod = Water_Animal.new(name: 'Cod', traits: {motion: motion[:mo7], skin: skin[:sk4], mouth: mouth[:m8], colour: colour[:c3], size: size[:s4], preferred_temp: preferred_temp[:t2], speed: speed[:sp4]})
eel = Water_Animal.new(name: 'Eel', traits: {motion: motion[:mo8], skin: skin[:sk3], mouth: mouth[:m4], colour: colour[:c5], size: size[:s2], preferred_temp: preferred_temp[:t4], speed: speed[:sp8]})

#Areal Animal list

finch = Areal_Animal.new(name: "Finch", traits: {motion: motion[:mo9], skin: skin[:sk5], mouth: mouth[:m10], colour: colour[:c2], size: size[:s6], preferred_temp: preferred_temp[:t5], speed: speed[:sp4]})
vulture = Areal_Animal.new(name: "Vulture", traits: {motion: motion[:mo9], skin: skin[:sk5], mouth: mouth[:m10], colour: colour[:c6], size: size[:s4], preferred_temp: preferred_temp[:t5], speed: speed[:sp2]})
albatross = Areal_Animal.new(name: "Albatross", traits: {motion: motion[:mo9], skin: skin[:sk5], mouth: mouth[:m10], colour: colour[:c1], size: size[:s4], preferred_temp: preferred_temp[:t3], speed: speed[:sp6]})
bat = Areal_Animal.new(name: "Bat", traits: {motion: motion[:mo9], skin: skin[:sk3], mouth: mouth[:m1], colour: colour[:c9], size: size[:s6], preferred_temp: preferred_temp[:t3], speed: speed[:sp8]})
dragonfly = Areal_Animal.new(name: "Dragonfly", traits: {motion: motion[:mo10], skin: skin[:sk6], mouth: mouth[:m9], colour: colour[:c6], size: size[:s5], preferred_temp: preferred_temp[:t3], speed: speed[:sp5]})
puffin = Areal_Animal.new(name: "Puffin", traits: {motion: motion[:mo9], skin: skin[:sk5], mouth: mouth[:m10], colour: colour[:c8], size: size[:s6], preferred_temp: preferred_temp[:t2], speed: speed[:sp4]})
falcon= Areal_Animal.new(name: "Falcon", traits: {motion: motion[:mo9], skin: skin[:sk5], mouth: mouth[:m10], colour: colour[:c3], size: size[:s6], preferred_temp: preferred_temp[:t3], speed: speed[:sp5]})
moth= Areal_Animal.new(name: "Moth", traits: {motion: motion[:mo10], skin: skin[:sk6], mouth: mouth[:m9], colour: colour[:c3], size: size[:s5], preferred_temp: preferred_temp[:t4], speed: speed[:sp7]})



puts jaguar.traits


#NEXT
#bring in the actural animals but add a Lives_on trait
#make an array of all the animals (possibly a nested hash?) and create a proper method for randomizing them and creating them and descriving them

#NOTE HERE, SUBCLASSES ARE EVERYTHING THEIR SUPERCLASSES ARE    AND   MORE!  The subclass is the actor. the superclass the container.
#Method within the subclasses that chooses swimming_fish, swimming_mammal, swimming_inverterbrates. Same with Land and Air.
