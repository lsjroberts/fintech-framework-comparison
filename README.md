# Web Framework Comparison for FinTech

A comparison of various web frameworks and languages for typical realworld financial web applications.

It is not intended that this comparison will come to a conclusion with a definitive "best" framework for building fintech apps. Instead it aims to provide a concrete real world baseline and support for discussion around the right choice for your specific company, project and team.

For each framework there is a breakdown of benchmark figures, a list of notable dependencies.

Each app has been built with typical dependencies that would be chosen for a real world app. Projects are not built with just the raw framework or language itself, so this serves as a comparison of the common ecosystem surrounding each.

Project template generators are used, such as [create-react-app](#), however full featured higher-order frameworks such as [Next.js](#) are treated separately.

Please remember, at the end of the day there is no absolute right or wrong framework, there is only the best fit for your team and your project.

## Features of a FinTech App

- Big grids of data, often virtualised, sometimes editable
- Charts, sparklines and more
- Streaming data, websockets of the latest prices and positions

## Frameworks & Languages

In alphabetical order, the technologies used are:

- ❌ [Angular](#Angular)
- 🚧 [Elm](#Elm)
- ❌ [Imba](#Imba)
- ❌ [React](#React)
- ❌ [Stencil](#Stencil)
- 🚧 [Svelte](#Svelte)
- ❌ [Vue](#Vue)

If you think a framework or language is missing, please [raise an issue](https://github.com/lsjroberts/fintech-framework-comparison/issues/new).

## Server

Each app connects to an [Elixir](https://elixir-lang.org/) [server](https://phoenixframework.org/) providing a [GraphQL](https://graphql.org/) endpoint. Where it exists, an [Apollo](https://www.apollographql.com/) client is used for the framework in question.

**Getting Started**

```
cd server
mix phx.server
```

## Angular

❌ Not started

https://angular.io/

**Dependencies**

- [typescript](#)

## Elm

🚧 Work in progress

https://elm-lang.org/

**Setup**

```
npm i -g create-elm-app
create-elm-app elm
```

**Getting Started**

```
cd elm
elm-app start
```

**Dependencies**

- [elm-graphql](https://package.elm-lang.org/packages/dillonkearns/elm-graphql/latest)
- [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest)

## Imba

❌ Not started

http://imba.io/

...

## React

❌ Not started

https://reactjs.org/

**Dependencies**

- [create-react-app](#)
- [react-router](#)
- [typescript](#)

## Stencil

❌ Not started

https://stenciljs.com/

**Setup**

```
npm init stencil
> ✔ Pick a starter › app
> ✔ Project name › stencil
```

## Svelte

🚧 Work in progress

https://svelte.dev/

**Dependencies**

- [svelte-apollo](https://github.com/timhall/svelte-apollo)
- [svelte-routing](https://github.com/EmilTholin/svelte-routing)

**Setup**

```
npx degit sveltjs/template svelte
```

**Getting Started**

```
cd svelte
npm install
npm run dev
```

## Vue

❌ Not started

https://vuejs.org/

**Setup**

```
npm i -g @vue/cli
vue create vue
```

**Getting Started**

```
cd vue
npm install
npm run serve
```
