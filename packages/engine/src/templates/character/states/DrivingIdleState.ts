import { StateSchemaValue } from '../../../state/interfaces/StateSchema';
import { initializeCharacterState } from "../behaviors/initializeCharacterState";
import { setActorAnimation } from "../behaviors/setActorAnimation";
import { setArcadeVelocityTarget } from '../behaviors/setArcadeVelocityTarget';
import { updateCharacterState } from "../behaviors/updateCharacterState";
import { CharacterStateGroups } from '../CharacterStateGroups';
import { CharacterComponent } from '../components/CharacterComponent';

// Idle Behavior
export const DrivingIdleState: StateSchemaValue = {
  group: CharacterStateGroups.MOVEMENT,
  componentProperties: [{
    component: CharacterComponent,
    properties: {
      ['velocitySimulator.damping']: 0.6,
      ['velocitySimulator.mass']: 10
    }
  }],
  onEntry: [
    {
      behavior: initializeCharacterState
    },
    {
      behavior: setArcadeVelocityTarget,
      args: { x: 0, y: 0, z: 0 }
    },
    {
      behavior: setActorAnimation,
      args: {
        name: 'driving',
        transitionDuration: 0.1
      }
    }
  ],
  onUpdate: [
    {
      behavior: updateCharacterState,
      args: {
        setCameraRelativeOrientationTarget: true
      }
    },
    /*
    {
      behavior: triggerActionIfMovementHasChanged,
      args: {
        action: (entity:Entity): void => {
          // Default behavior for all states
          findVehicle(entity);
          const input = getComponent(entity, Input)

          // Check if we're trying to jump
          if (input.data.has(DefaultInput.JUMP) && input.data.get(DefaultInput.JUMP).value === BinaryValue.ON) {
            return addState(entity, {state: CharacterStateTypes.JUMP_IDLE})
          }

          // If we're not moving, don't worry about the rest of this action
          if (!isMoving(entity)) return

          // If our character is moving or being moved, go to walk state
          if (getComponent(entity, CharacterComponent).velocity.length() > 0.5)
            return addState(entity, { state: CharacterStateTypes.WALK })

          // Otherwise set the appropriate walk state
          setAppropriateStartWalkState(entity);
        }
      }
    },
    {
      behavior: setFallingState
    }
    */
  ]
};