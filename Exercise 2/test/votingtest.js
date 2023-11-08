const {except, expect} = require('chai')
const {ethers} = require('hardhat')

describe ('Votingsystem' , function(){
let owner,voter1,voter2,votingsystem;


beforeEach(async function () {
[owner] = await ethers.getsigners ()
const Votingsystem =await ethers.getcontractfactory("Votingsystem") ;
votingsystem = await deploy.votingsystem(["candidate1","candidate2"]);
await votingsystem.deployed ();
});

it ("should deploy and count the candidate",async function (){
              const Candidatecount = await votingsystem.getCandidatescount();
              expect (Candidatecount).to.equal(2);
});

it ("should initialize the write contract",async function(){
  const candidate1Name = await votingSystem.candidates(0);
  const candidate2Name = await votingSystem.candidates(1);

  expect(candidate1Name).to.equal(candidate1);
  expect(candidate2Name).to.equal(candidate2);
})

it("should prevent double voting", async function () {
              await votingsystem.connect(voter1).vote(1);
              await expect(votingsystem.connect(voter1).vote(0)).to.be.revertedWith("Already voted");
            });

it("should add candidate",async function (){
    await votingsystem.connect (owner). addcandidate(["candidate 3"]);
    const votingsystem = await votingsystem.getCandidatescount();
    expect (Candidatecount).to.equal(3);          
});

it("should remove candidate",async function (){
              await votingsystem.connect (owner).removecandidate(1);
              const votingsystem = votingsystem.getCandidatescount();
              expect (Candidatecount).to.equal(1);
});

it ("should allow onlyowner can add cadidate ", async function (){
const  nonOwner = voter1;
await expect(votingsystem.connect(nonOwner).addCandidate("Candidate D"))
.to.be.revertedWith("Only Owner Can Perform Add Function");

});

it ("should allow onlyowner can remove cadidate ", async function (){
              const  nonOwner = voter1;
              await expect(votingsystem.connect(nonOwner).removeCandidate(2))
              .to.be.revertedWith("Only Owner Can Perform remove Function");
});
});