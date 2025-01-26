import 'package:graphql_flutter/graphql_flutter.dart';

class AppWriteService {
  late final GraphQLClient _client;

  AppWriteService() {
    final HttpLink httpLink = HttpLink(
      'https://cloud.appwrite.io/v1/graphql',
    );

    _client = GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: httpLink,
    );
  }

  // Função para criar um usuário via GraphQL
  Future<Map<String, dynamic>> createUserGraphQL({
    required String email,
    required String password,
  }) async {
    const String mutation = """
      mutation CreateUser(\$email: String!, \$password: String!) {
        createUser(email: \$email, password: \$password) {
          id
          email
        }
      }
    """;

    final options = MutationOptions(
      document: gql(mutation),
      variables: <String, dynamic>{
        'email': email,
        'password': password,
      },
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data?['createUser'] as Map<String, dynamic>;
  }

  Future<void> createUserProfileGraphQL({
    required String userId,
    required String name,
    required int age,
    required int cpf,
    required int phone,
  }) async {
    const String mutation = """
      mutation CreateUserProfile(\$userId: String!, \$name: String!, \$age: Int!, \$cpf: Int!, \$phone: Int!) {
        createUserProfile(userId: \$userId, name: \$name, age: \$age, cpf: \$cpf, phone: \$phone) {
          id
          name
        }
      }
    """;

    final options = MutationOptions(
      document: gql(mutation),
      variables: <String, dynamic>{
        'userId': userId,
        'name': name,
        'age': age,
        'cpf': cpf,
        'phone': phone,
      },
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
  }
}
