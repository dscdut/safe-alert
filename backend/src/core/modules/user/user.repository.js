import { DataRepository } from 'packages/restBuilder/core/dataHandler/data.repository';

class Repository extends DataRepository {
    findByEmail(email) {
        return this.query()
            .innerJoin('users_roles', 'users_roles.user_id', 'users.id')
            .innerJoin('roles', 'roles.id', 'users_roles.role_id')
            .whereNull('users.deleted_at')
            .where('users.email', '=', email)
            .select(
                'users.id',
                'users.email',
                'users.password',
                { role: 'roles.name' },
                { fullName: 'users.full_name' },
                { createdAt: 'users.created_at' },
                { updatedAt: 'users.updated_at' },
                { deletedAt: 'users.deleted_at' },
            );
    }

    findById(id) {
        return this.query()
            .innerJoin('users_roles', 'users_roles.user_id', 'users.id')
            .innerJoin('roles', 'roles.id', 'users_roles.role_id')
            .whereNull('users.deleted_at')
            .where('users.id', '=', id)
            .select(
                'users.id',
                'users.email',
                { fullName: 'users.full_name' },
                { role: 'roles.name' },
                { createdAt: 'users.created_at' },
                { updatedAt: 'users.updated_at' },
                { deletedAt: 'users.deleted_at' },
            );
    }

    findRoles(id) {
        return this.query().innerJoin('users_roles', 'users_roles.user_id', 'users.id').where('users.id', '=', id).select('roles.name');
    }
}

export const UserRepository = new Repository('users');
