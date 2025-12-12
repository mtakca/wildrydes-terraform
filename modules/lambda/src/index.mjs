import { randomBytes } from 'crypto';
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, PutCommand } from '@aws-sdk/lib-dynamodb';

const client = new DynamoDBClient({});
const ddb = DynamoDBDocumentClient.from(client);
const tableName = process.env.DYNAMODB_TABLE;

const fleet = [
  { Name: 'Angel', Color: 'White', Gender: 'Female' },
  { Name: 'Gil', Color: 'White', Gender: 'Male' },
  { Name: 'Rocinante', Color: 'Yellow', Gender: 'Female' },
];

export const handler = async (event, context) => {
  if (!event.requestContext.authorizer) {
    return errorResponse('Authorization not configured', context.awsRequestId);
  }

  const rideId = toUrlString(randomBytes(16));
  const username = event.requestContext.authorizer.claims['cognito:username'];
  const requestBody = JSON.parse(event.body);
  const pickupLocation = requestBody.PickupLocation;

  const unicorn = findUnicorn(pickupLocation);

  try {
    await recordRide(rideId, username, unicorn);
    return {
      statusCode: 201,
      body: JSON.stringify({
        RideId: rideId,
        Unicorn: unicorn,
        Eta: '30 seconds',
        Rider: username,
      }),
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
    };
  } catch (err) {
    console.error(err);
    return errorResponse(err.message, context.awsRequestId);
  }
};

function findUnicorn(pickupLocation) {
  console.log('Finding unicorn for ', pickupLocation.Latitude, ', ', pickupLocation.Longitude);
  return fleet[Math.floor(Math.random() * fleet.length)];
}

async function recordRide(rideId, username, unicorn) {
  const params = {
    TableName: tableName,
    Item: {
      RideId: rideId,
      User: username,
      Unicorn: unicorn,
      RequestTime: new Date().toISOString(),
    },
  };
  await ddb.send(new PutCommand(params));
}

function toUrlString(buffer) {
  return buffer.toString('base64')
    .replace(/\+/g, '-')
    .replace(/\//g, '_')
    .replace(/=/g, '');
}

function errorResponse(errorMessage, awsRequestId) {
  return {
    statusCode: 500,
    body: JSON.stringify({
      Error: errorMessage,
      Reference: awsRequestId,
    }),
    headers: {
      'Access-Control-Allow-Origin': '*',
    },
  };
}
