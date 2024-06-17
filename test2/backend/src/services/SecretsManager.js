import {
  GetSecretValueCommand,
  SecretsManagerClient,
} from '@aws-sdk/client-secrets-manager'

const client = new SecretsManagerClient({
  region: process.env.AWS_REGION,
})

async function getSecretValue(secretName) {
  let secret
  try {
    const data = await client.send(
      new GetSecretValueCommand({
        SecretId: secretName,
      })
    )

    if (data.SecretString) {
      secret = JSON.parse(data.SecretString)
    } else {
      throw `Secret ${secretName} not found.`
    }
  } catch (error) {
    throw error
  } finally {
    return secret
  }
}

export { getSecretValue }
