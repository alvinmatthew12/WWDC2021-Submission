import Foundation

struct Material {
    let key: String
    let name: String
    let symbol: String
    let atomicNumber: String
    let atomicMass: String
    let desccription: String
}

struct MaterialData {
    let materials: [Material] = [
        Material(key: "GoldMaterial", name: "Gold", symbol: "Au", atomicNumber: "79", atomicMass: "196.967",
                 desccription: "DEFINITION\n\nGold is a member of the transition metals and sits in the same periodic table column as silver and copper. The group that gold can be found in is often termed the 'coinage metal' group since its members are frequently used to produce money. Like all other metals, gold is also highly malleable and ductile. Moreover, gold is able to conduct both electricity and heat rather easily.\n\n\nUSAGE\n\nThis precious metal doesn’t just make very pretty jewellery – it’s highly prized for use in making mobile phones because it is chemically stable and conducts electricity. Small amounts of gold are used to make the mobile phone circuit board."),
        Material(key: "LithiumMaterial", name: "Lithium", symbol: "Li", atomicNumber: "3", atomicMass: "6.941 u",
                 desccription: "DEFINITION\n\nLithium, the alkali metal group, lightest of the solid elements. The metal itself—which is soft, white, and lustrous—and several of its alloys and compounds are produced on an industrial scale.\n\n\nUSAGE\n\nThe principal industrial applications for lithium metal are in metallurgy, where the active element is used as a scavenger (remover of impurities) in the refining of such metals as iron, nickel, copper, and zinc and their alloys. Lithium is primarily used in the production of mobile-phone batteries. It is mined from salt lakes and hard-rock ore."),
        Material(key: "AluminiumMaterial", name: "Aluminium", symbol: "Ai", atomicNumber: "13", atomicMass: "26.981539 u",
                 desccription: "DEFINITION\n\nAluminium is a weak metal that has low density, is non-toxic, has a high thermal conductivity, has excellent corrosion resistance and can be easily cast, machined and formed. It is also non-magnetic and non-sparking. It is the second most malleable metal and the sixth most ductile.\n\n\nUSAGE\n\nAluminium is used in a huge variety of products including cans, foils, kitchen utensils, window frames, beer kegs and aeroplane parts. This is because of its particular properties. Aluminium also used in mobile phone cases and components."),
        Material(key: "CobaltMaterial", name: "Cobalt", symbol: "Co", atomicNumber: "27", atomicMass: "58.933195 u",
                 desccription: "DEFINITION\n\nCobalt is found in the Earth's crust only in a chemically combined form, save for small deposits found in alloys of natural meteoric iron. The element, produced by reductive smelting, is a hard, lustrous, silver-gray metal. Miners had long used the name kobold ore (German for goblin ore) for some of the blue-pigment-producing minerals.\n\n\nUSAGE\n\nCobalt is a metal used in numerous diverse commercial, industrial, and military applications, many of which are strategic and critical.  On a global basis, the leading use of cobalt is in rechargeable battery electrodes."),
    ]
}

// Gold
//https://study.com/academy/lesson/what-is-gold-definition-properties-uses.html#:~:text=Gold%20is%20a%20soft%2C%20yellow,also%20highly%20malleable%20and%20ductile.&text=The%20atomic%20number%20of%20gold,centimeter%2C%20slightly%20greater%20than%20lead.

// Lithium
//https://en.wikipedia.org/wiki/Lithium#:~:text=Lithium%20(from%20Greek%3A%20%CE%BB%CE%AF%CE%B8%CE%BF%CF%82%2C,%2C%20silvery%2Dwhite%20alkali%20metal.&text=Like%20all%20alkali%20metals%2C%20lithium,be%20stored%20in%20mineral%20oil.
//https://www.britannica.com/science/lithium-chemical-element

// Aluminium
//https://www.rsc.org/periodic-table/element/13/aluminium#:~:text=Aluminium%20is%20a%20silvery%2Dwhite,It%20is%20soft%20and%20malleable.&text=Aluminium%20is%20used%20in%20a,because%20of%20its%20particular%20properties.

// Cobalt
//https://en.wikipedia.org/wiki/Cobalt
