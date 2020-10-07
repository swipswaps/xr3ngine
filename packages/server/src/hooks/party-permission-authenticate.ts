import { HookContext } from '@feathersjs/feathers';
import { extractLoggedInUserFromParams } from '../services/auth-management/auth-management.utils';
import { BadRequest, Forbidden } from '@feathersjs/errors';

// This will attach the owner ID in the contact while creating/updating list item
export default () => {
  return async (context: HookContext): Promise<HookContext> => {
    let fetchedPartyId;
    const { id, method, params, app, path } = context;
    const loggedInUser = extractLoggedInUserFromParams(params);
    if (path === 'party-user' && method === 'remove') {
      const partyUser = await app.service('party-user').get(id);
      fetchedPartyId = partyUser.partyId;
    }
    const partyId = path === 'party-user' && method === 'find' ? params.query.partyId : fetchedPartyId != null ? fetchedPartyId : id;
    if (method !== 'patch') {
      params.query.partyId = partyId;
    }
    const userId = path === 'party' ? loggedInUser?.userId : params.query?.userId || loggedInUser?.userId || partyId;
    const partyUserCountResult = await app.service('party-user').find({
      query: {
        partyId: partyId,
        $limit: 0
      }
    });
    if (partyUserCountResult.total > 0) {
      const partyUserResult = await app.service('party-user').find({
        query: {
          partyId: partyId,
          userId: userId
        }
      });
      if (partyUserResult.total === 0) {
        throw new BadRequest('Invalid party ID');
      }
      const partyUser = partyUserResult.data[0];
      if (params.partyUsersRemoved !== true && partyUser.isOwner !== true && partyUser.isOwner !== 1 && partyUser.userId !== loggedInUser.userId) {
        throw new Forbidden('You must be the owner of this party to perform that action');
      }
    }

    return context;
  };
};