const express = require('express')

const { SemVer } = require('../version')

const app = express()
const port = process.env.PORT || 3000

app.get('/', (req, res) => {
  res.send(`Hello World! ${SemVer}`)
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})