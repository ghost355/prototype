// GameAction.swift

enum GameAction: Equatable {
    enum Game: Equatable {
        case exit
    }

    enum Phase: Equatable {
        case finish
        case advance(to: GamePhase)
    }

    enum Movement: Equatable {
        case move(id: UnitID, to: GridCoordinate, generalInitiative: Bool)
        case useInitiative(id: UnitID, to: GridCoordinate)
        case infiltrate(id: UnitID, to: GridCoordinate)
        case infiltratePlatoon(hq: UnitID, to: GridCoordinate)
        case seekCover(id: UnitID)
        case moveWithin(id: UnitID, to: GridCoordinate)
        case movePlatoon(hq: UnitID, to: GridCoordinate)
        case pickup(id: UnitID, target: UnitID)
    }

    enum Combat: Equatable {
        case spotEnemy(unitID: UnitID, target: UnitID)
        case concentrateFire(unitID: UnitID, target: UnitID)
        case grenadeAttack(unitID: UnitID, target: UnitID)
        case callForFire(observer: UnitID, target: GridCoordinate)
        case callForIndirectFire(observer: UnitID, target: GridCoordinate)
        case ceaseFire(unitID: UnitID)
        case shiftFire(unitID: UnitID, target: GridCoordinate)
        case placeDemolition(unitID: UnitID, target: GridCoordinate)
        case throwDemolition(unitID: UnitID, target: GridCoordinate)
        case flamethrowerAttack(unitID: UnitID, target: GridCoordinate)
        case fireFPF(unitID: UnitID)
        case fireFPL(unitID: UnitID)
        case platoonConcentrateFire(hq: UnitID, target: GridCoordinate)
        case platoonGrenadeAttack(hq: UnitID, target: GridCoordinate)
    }

    enum Control: Equatable {
        case activateHQ(unitID: UnitID)
        case exhort(unitID: UnitID)
        case reconstitutePlatoonHQ(unitID: UnitID, from: UnitID)
        case reconstituteCOHQ(from: UnitID)
        case createRunner(from: UnitID)
        case dispatchRunner(runnerID: UnitID, to: UnitID)
        case dismissRunner(runnerID: UnitID)
        case deployPyrotechnic(unitID: UnitID, signal: String)
        case switchNetwork(unitID: UnitID, to: String)
        case repairCutLine(unitID: UnitID)
        case activateForATCombat(unitID: UnitID)
        case designateTacticalControl(type: String, coordinate: GridCoordinate)
    }

    enum Rally: Equatable {
        case removePinned(unitID: UnitID)
        case convertParalyzeToLitter(unitID: UnitID)
        case convertLitterToFire(unitID: UnitID)
        case convertFireToAssault(unitID: UnitID)
        case convertAssaultToFire(unitID: UnitID)
        case flipToFireTeamSide(unitID: UnitID)
        case flipFromFireTeamSide(unitID: UnitID)
        case detachTeam(unitID: UnitID)
        case supplementSquad(squadID: UnitID, teamID: UnitID)
        case reconstituteSquad(teams: [UnitID], squadID: UnitID)
    }

    enum Enemy: Equatable {
        case activityCheck
        case fallBack(unitID: UnitID)
        case shiftFire(unitID: UnitID, target: GridCoordinate)
        case callForFire(spotter: UnitID, target: GridCoordinate) // Вражеский вызов огня
        case grenadeAttack(unitID: UnitID, target: UnitID) // Вражеская гранатная атака
    }

    case game(Game)
    case phase(Phase)
    case movement(Movement)
    case combat(Combat)
    case control(Control)
    case rally(Rally)
    case enemy(Enemy)
}
