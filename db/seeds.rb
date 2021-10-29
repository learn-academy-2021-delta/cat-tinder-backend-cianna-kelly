cats = [
    {
        name: "Mr. Bigglesworth",
        age: 8,
        enjoys: "Pure evil"
    },
    {
        name: "Thackery Binx",
        age: 5,
        enjoys: "Saving children from witches"
    },
    {
        name: "Oliver",
        age: 5,
        enjoys: "Long walks through New York City"
    },
    {
        name: "Kitty",
        age: 3,
        enjoys: "Sleeping on the windowsill in the sunlight"
    }
]

cats.each do |attributes|
    Cat.create attributes
    p "creating cats #{attributes}"
end