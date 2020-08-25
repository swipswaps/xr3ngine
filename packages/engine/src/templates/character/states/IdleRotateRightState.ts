import { StateSchemaValue } from '../../../state/interfaces/StateSchema';
import { CharacterComponent } from '../../../character/components/CharacterComponent';
import { setCharacterAnimation, checkFalling } from '../CharacterStateSchema';
import { initializeCharacterState, updateCharacterState } from '../behaviors/CharacterBaseBehaviors';
import { CharacterStateGroups } from '../CharacterStateGroups';
import { onAnimationEnded } from '../behaviors/onAnimationEnded';
import { IdleState } from './IdleState';

export const IdleRotateRightState: StateSchemaValue = {
  group: CharacterStateGroups.MOVEMENT,
  componentProperties: {
    component: CharacterComponent,
    properties: {
      ['velocitySimulator.mass']: 10,
      ['velocitySimulator.damping']: 0.6,
      ['rotationSimulator.mass']: 30,
      ['rotationSimulator.damping']: 0.6,
      ['velocityTarget']: { x: 0, y: 0, z: 0 },
    }
  },
  onEntry:  [
      {
        behavior: initializeCharacterState
      },
      {
        behavior: setCharacterAnimation,
        args: {
          name: 'rotate_right',
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
    {
      behavior: onAnimationEnded,
      args: {
        transitionToState: IdleState
      }
    },
    {
      behavior: checkFalling
    }
  ]
};

