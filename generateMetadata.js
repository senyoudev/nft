const fs = require('fs')

fs.mkdirSync('metadata')

for(let i=1;i<=5;i++) {
    let metadata = {}
    metadata.name = `Token ${i}`
    metadata.description = `Description for Token ${i}`
    metadata.image = "ipfs://QmXufz9YaTTT2gNPzHV6aWq9hBCV8mbKPNF2Hyg77rn7yN/" + i + ".png"
    fs.writeFileSync(`./metadata/${i}.json`,JSON.stringify(metadata))
    }

