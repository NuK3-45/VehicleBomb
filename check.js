const superagent = require('superagent');

//Declare Version for version checker
let version = 1.1

async function Main() {

    //Get Newest version from my Website
    const { body } = await superagent
        .get("https://hypnoticsiege.codes/api/vehiclebomb/version.json");
    console.log(`[Vehicle Bomb] You are running Version: ${version} | Newest Version: ${body.version}`)

    //If declared version is less that newest version
    if (version < body.version) {
        console.log(`Vehicle Bomb is Out of Date! Please update for stability at https://github.com/NuK3-45/VehicleBomb`)
    }
    //If up to date
    else {
        console.log(`Vehicle Bomb is Up to Date!`)
    }
}

Main()