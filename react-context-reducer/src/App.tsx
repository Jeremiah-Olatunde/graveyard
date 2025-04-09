import { createContext, useContext, useReducer } from "react";
import "./App.css";

export default function App() {
	return (
		<ProviderUsers>
			<Core />
		</ProviderUsers>
	);
}

function Core() {
	const { users, dispatch } = useContextUsers();
	return (
		<section>
			<h1>Context Reducers</h1>
			<ul>
				{users.map((user) => {
					return (
						<li key={user.id}>
							{user.id}
							<button onClick={() => dispatch({ type: "delete", user })}>
								delete user
							</button>
						</li>
					);
				})}
			</ul>
			<button onClick={() => dispatch({ type: "create" })}>add user</button>
		</section>
	);
}

type User = {
	id: string;
};

type StateUsers = User[];
type DispatchUsers = (action: ActionUsers) => void;

type ActionUsersAdd = { type: "add"; user: User };
type ActionUsersDelete = { type: "delete"; user: User };
type ActionUsersCreate = { type: "create" };
type ActionUsers = ActionUsersAdd | ActionUsersDelete | ActionUsersCreate;

const ContextUsers = createContext<{
	users: StateUsers;
	dispatch: DispatchUsers;
} | null>(null);

function useContextUsers() {
	const users = useContext(ContextUsers);
	if (users === null) throw new Error("context value not provided");
	return users;
}

function reducerUsers(state: StateUsers, action: ActionUsers): StateUsers {
	switch (action.type) {
		case "add":
			return [...state, action.user];
		case "delete":
			return state.filter((user) => user.id !== action.user.id);
		case "create":
			return [...state, generateUser()];
	}
}

function ProviderUsers({ children }: { children: React.ReactNode }) {
	const [users, dispatch] = useReducer(reducerUsers, [], generateUsers);

	return (
		<ContextUsers.Provider value={{ users, dispatch }}>
			{children}
		</ContextUsers.Provider>
	);
}

function generateUser(): User {
	return { id: crypto.randomUUID() };
}

function generateUsers(): User[] {
	const users: User[] = [];
	for (let i = 0; i < 10; i++) users.push(generateUser());
	return users;
}
